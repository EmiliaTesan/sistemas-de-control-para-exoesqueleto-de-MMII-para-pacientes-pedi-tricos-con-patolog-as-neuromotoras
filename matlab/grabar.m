function grabar(nombre_archivo, duracion, mm)
    % nombre_archivo: nombre del archivo donde se guardarán los datos
    % duracion: tiempo en segundos que durará la grabación
    % mm: objeto MyoMex ya inicializado 

    if nargin < 3
        error('proporcionar un nombre de archivo, una duracion y la variable MyoMex.');
    end

    %acceder a datos de la Myo
    myoData = mm.myoData;
    %matriz para almacenar los datos
    data = [];

    disp('grabando datos...');
    tic;
    while toc < duracion
        emg=myoData.emg_log; %señales EMG (8 canales)
        gyro=myoData.gyro_log; %datos del giroscopio (XYZ)
        accel=myoData.accel_log; %datos del acelerómetro (XYZ)

        %concatenar (tiempo, EMG, giroscopio, acelerómetro)
        fila=[toc, emg(end,:), gyro(end,:), accel(end,:)];
        data=[data; fila];
        pause(0.01); %sincronizar
    end

    disp('grabación lista!');
    csvwrite(nombre_archivo, data);
    disp(['datos guardados en ', nombre_archivo]);
end
