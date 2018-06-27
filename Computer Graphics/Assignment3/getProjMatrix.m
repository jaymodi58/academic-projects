function P = getProjMatrix(i)
% Projection matrix for Camera i
%
% Projection matrices are hardcoded for simplicity. But, we could just read
% them directly from the calibration files. 

    Calib(1).P = [ 1.483215e+03 -7.953666e+02 -9.153119e+02 4.046004e+03; ...
                  -5.395400e+01 -1.719494e+03  3.606972e+02 3.961539e+03; ...
                  -6.991278e-02 -9.069575e-01 -1.063456e+00 4.753082e+00 ];

    Calib(2).P = [ 1.677218e+03 -7.084734e+02 5.732087e+02 5.171564e+03; ...
                  -1.814967e+02 -1.743858e+03 3.993065e+00 4.314523e+03; ...
                   8.810557e-01 -7.603295e-01 -7.786652e-01 6.074740e+00 ];

    Calib(3).P = [  9.269854e+02 -7.025415e+02 1.509225e+03 4.448627e+03; ...
                   -1.922770e+02 -1.737088e+03 -7.511179e+01 4.261084e+03; ...
                    1.152985e+00 -7.936465e-01 -3.782901e-02 5.152725e+00 ];

    Calib(4).P = [ -3.529096e+02 -6.068026e+02 1.769746e+03 4.453332e+03; ...
                   -5.880053e+01 -1.765468e+03 -8.726954e+01 4.527056e+03; ...
                    8.825374e-01 -7.435539e-01 7.937028e-01 6.003132e+00 ];

    Calib(5).P = [ -1.532662e+03 -7.698217e+02 8.246429e+02 3.787523e+03; ...
                    2.544591e+01 -1.720718e+03 -4.054952e+02 3.874761e+03; ...
                    1.776188e-02 -9.415247e-01 1.036173e+00 4.695420e+00 ];

    Calib(6).P = [ -1.732989e+03 -5.827524e+02 -6.096631e+02 4.869964e+03; ...
                    8.629205e+01 -1.771143e+03 -1.076821e+02 4.426927e+03; ...
                   -9.177131e-01 -7.547954e-01 7.410083e-01 6.032102e+00 ];

    Calib(7).P = [ -8.914168e+02 -6.960165e+02 -1.548135e+03 4.017688e+03; ...
                    2.466475e+02 -1.750562e+03 2.269384e+01 4.171231e+03; ...
                   -1.119922e+00 -8.401569e-01 2.586530e-04 5.181506e+00 ];

    Calib(8).P = [  4.011197e+02 -5.661652e+02 -1.788971e+03 4.441950e+03; ...
                    1.039635e+02 -1.761553e+03 4.867437e+01 4.503671e+03; ...
                   -8.417806e-01 -7.415664e-01 -8.374394e-01 6.065466e+00 ];

    P = Calib( i ).P;
    
return