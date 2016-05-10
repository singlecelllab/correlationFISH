function fileshiftresults=shiftcorrect(filetemp,fileregister)

 
    x_correlation = xcorr2(double(imcrop(filetemp,[400 400 300 300])),double(imcrop(fileregister,[400 400 300 300])));
    
    % Find the maximum correlation point
    [maxX,ind] = max(x_correlation(:));
    [corr_max_v,corr_max_h] = ind2sub(size(x_correlation),ind);
     
    [v_size,h_size] = size(x_correlation);
    
    shifted_images_v_shift = corr_max_v - round(v_size/2);
    shifted_images_h_shift = corr_max_h - round(h_size/2);

    v_shift_round = round(shifted_images_v_shift);
    h_shift_round = round(shifted_images_h_shift);
      
    fileshiftresults=[v_shift_round h_shift_round];

   
end
