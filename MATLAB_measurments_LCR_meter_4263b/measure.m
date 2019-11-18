function [measurements] = measure(vs, data_amount)
    trigger_time_s = 1;

    measurements = zeros(2, data_amount);
    for i=1:data_amount
        pause(trigger_time_s) % triggering and fetching 1 second
        fprintf(vs,":FETCh?"); % after one *TRG data can be fetched
        data = fscanf(vs);
        data = strsplit(data, ',')
        measurements(1, i) = str2double(data(2));
        measurements(2, i) = str2double(data(3));

    end
end


