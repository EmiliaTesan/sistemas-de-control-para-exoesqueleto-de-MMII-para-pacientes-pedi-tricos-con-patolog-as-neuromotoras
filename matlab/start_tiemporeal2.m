mm.myoData.startStreaming();  
pause(1);  

%inicializado variables de almacenamiento de datos
gyro_data = zeros(1, 3); %3 canales giroscopio   
accel_data = zeros(1, 3); %3 canales acelerometro  
emg_data = zeros(1, 8); %8 canales EMG    

figure;
tiledlayout(3, 1);  

T = 5; %tiempo de grabacion en segundos
tic;  

while toc < T 
    new_gyro = mm.myoData.gyro;
    new_accel = mm.myoData.accel;
    new_emg = mm.myoData.emg;
    
    gyro_data = [gyro_data; new_gyro];  
    accel_data = [accel_data; new_accel];
    emg_data = [emg_data; new_emg];  
    
    %actualizar las gráficas en tiempo real
    %giroscopio
    nexttile(1);  
    plot(gyro_data);  
    title('giroscopio');
    ylim([-50 50]);  %rango de visibilidad
    
    %acelerómetro
    nexttile(2);  
    plot(accel_data);  
    title('acelerometro');
    ylim([-2 2]);  

    %EMG
    nexttile(3);  
    plot(emg_data);  
    title('EMG');
    ylim([-0.5 0.5]);  

    drawnow;
    pause(0.01);
end

mm.myoData.stopStreaming();

% disp('Tamanio de los datos capturados:');
% disp(size(gyro_data));   
% disp(size(accel_data));  
% disp(size(emg_data));    
disp(gyro_data)