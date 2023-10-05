codeunit 50111 "PKT Profiler Management"
{
    SingleInstance = true;

    procedure Start()
    var
        FileName: Text;
        SamplingInterval : Enum "Sampling Interval";
    begin

        if (SamplingPerformanceProfiler.IsRecordingInProgress()) or
           (Session.CurrentExecutionMode = ExecutionMode::Debug) then 
            exit;
        
        //Collect sample every 50ms
        SamplingInterval := SamplingInterval::SampleEvery50ms;
        SamplingPerformanceProfiler.Start(SamplingInterval);

        //Do your stuff
        Report.run(Report::"Item Ledger Entry Analysis",false);

        SamplingPerformanceProfiler.Stop();

        FileName := 'TraceCollection.alcpuprofile';
        DownloadFromStream(SamplingPerformanceProfiler.GetData(), '', '', '', FileName);

    end;

    var
        SamplingPerformanceProfiler: Codeunit "Sampling Performance Profiler";
}