cd('C:\Users\Franc\OneDrive\Documentos\myoMATLAB') %donde estan archivos de MyoMex

clear mex
rehash toolboxcache

%ruta a las DLL de Myo SDK esté correctamente añadida al PATH
setenv('PATH', [getenv('PATH') ...
    ';C:\Users\Franc\OneDrive\Documentos\myoMATLAB\myoSDK\bin']);

%carpeta con archivo MEX de myo_mex a MATLAB
addpath('C:\Users\Franc\OneDrive\Documentos\myoMATLAB\MyoMex\myo_mex');
savepath;
% Inicializar el número de Myo Armbands
countMyos = 1;

mm = MyoMex(countMyos);
disp('Myo Armband inicializada');