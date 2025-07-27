m1 = mm.myoData(1);%datos de la pulsera
pause(0.1); %esperar datos

%datos muestreados en base de tiempo IMU 
m1.timeIMU   %tiempo por muestra
m1.quat      %cuaterniones (orientación 3D del Myo)
m1.rot       %rotación 
m1.gyro      %datos giroscopio (velocidad angular)
m1.gyro_fixed %giroscopio con corrección de orientación
m1.accel     %aceleración lineal
m1.accel_fixed %acelerometro con corrección de orientación

%datos muestreados en base de tiempo EMG 
m1.timeEMG   %tiempo por muestra
m1.emg       
m1.pose      %infor poses brazo (general)
m1.pose_rest %descanso (sin movimiento)
m1.pose_fist %pose punio cerrado
m1.pose_wave_in %pose hacia adentro
m1.pose_wave_out %pose hacia afuera
m1.pose_fingers_spread %estirar dedos
m1.pose_double_tap %finger tapping
m1.arm       %info brazo (derecho izquierdo)
m1.arm_right %si es derecho
m1.arm_left  %izquierdo
m1.arm_unknown %brazo desconocido
m1.xDir      %direccion eje X
m1.xDir_wrist %direccion eje X munieca
m1.xDir_elbow %direccion eje X codo
m1.xDir_unknown %direccion eje X desconocida

m1 = mm.myoData(1); % Obtener datos de la pulsera
pause(0.1); % Esperar para recibir datos

% Imprimir encabezado de datos IMU
fprintf('%10s%10s%15s%15s%15s%15s%15s%15s\n', ...
    'Tiempo', 'Muestras', 'Gyro X', 'Gyro Y', 'Gyro Z', 'Acc X', 'Acc Y', 'Acc Z');

for ii = 1:5
    % Capturar datos de giroscopio y acelerómetro
    gyro = m1.gyro;   % Velocidad angular [X, Y, Z]
    accel = m1.accel; % Aceleración lineal [X, Y, Z]

    % Imprimir valores
    fprintf('% 8.2f%10d%15.2f%15.2f%15.2f%15.2f%15.2f%15.2f\n', ...
        m1.timeIMU, size(m1.quat_log, 1), ...
        gyro(1), gyro(2), gyro(3), accel(1), accel(2), accel(3));

    pause(0.2);  % Pausa entre iteraciones
end
fprintf('\n\n');

% Detener la adquisición
m1.stopStreaming();

% Imprimir cantidad de muestras adquiridas
fprintf('Número de muestras: \t%d\n', length(m1.timeIMU_log));
pause(1);  
fprintf('Número de muestras después de pause(1):\t%d\n', length(m1.timeIMU_log));

% Graficar datos IMU y EMG
figure;
subplot(3,1,1); plot(m1.timeIMU_log, m1.gyro_log); title('Giroscopio');   
subplot(3,1,2); plot(m1.timeIMU_log, m1.accel_log); title('Acelerómetro');  
subplot(3,1,3); plot(m1.timeEMG_log, m1.emg_log); title('EMG');  

% Limpiar logs antes de una nueva captura
T = 3; % Tiempo de captura en segundos
m1.clearLogs();

% Reiniciar la adquisición
m1.startStreaming();
pause(T); 
m1.stopStreaming();