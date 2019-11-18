function [vs] = configure(a_correction)
    %% Read and setup Agilent 4263B LCR Meter
    %instrhwinfo('visa', 'ni', 'gpib')

    existing_vs = instrfind();
    delete(existing_vs)
    
    vs = visa('ni','GPIB0::10::INSTR');
    
    fopen(vs); % check if opened already
    
    fprintf(vs,"*IDN?"); %identify the system connected
    fscanf(vs)
    
    %% Perform corrections
    if a_correction
        fprintf(vs,"*RST");  %reset instrument

        disp("Prepare open correction (short L and H separately), then press 'Enter'.");
        pause;
        fprintf(vs,":SENS:CORR:COLL STAN1"); % open correction 
        fprintf(vs,"*OPC?"); % Operation complete query: waint until completed

        disp("Short all connections, then press 'Enter'.");
        pause;
        fprintf(vs,":SENS:CORR:COLL STAN2"); % short correction
        fprintf(vs,"*OPC?"); 
    end

    disp("Prepare measurement, then press 'Enter'.");
    pause;
    
    %% configure device
    fprintf(vs,":CAL:CABL 1"); %test fixture cable length 1 meter
    fprintf(vs, ":SOUR:FREQ 100"); % set signal frequency 
    
    % Set R, X mode
    fprintf(vs, ":SENS:FUNC 'FIMP'");
    fprintf(vs, ":CALC1:FORM REAL");
    fprintf(vs, ":CALC2:FORM IMAG");

    fprintf(vs, ":SENS:FIMP:APER 0.5"); % Measurement frequency long
    fprintf(vs, ":SENS:AVER:COUN 1"); % set averaging rate

    %% Configure measurements
    fprintf(vs,":INIT:CONT ON"); % Initiating trigger system
end