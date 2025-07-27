mm.myoData.startStreaming(); 
pause(1);  
emg_data = [];  

%graficar en tiempo real
figure;
h = gcf;  %identificador de la figura
tiledlayout(8, 1);  %8 subgráficas

T = 10;%definir el tiempo grabacion en segundos
tic;  %start temporizador

while toc < T  %bucle durante T segundos
    new_data = mm.myoData.emg;
    emg_data = [emg_data; new_data];  %agregar datos a la variable emg_data
    
    %actualizar figure en tiempo real
    for ch = 1:8  
        nexttile(ch); 
        plot(emg_data(:, ch));  %graficar datos del canal
        title(['canal ' num2str(ch)]);  
        ylim([-0.3 0.3]);  %ajustar rango para mejorar visibilidad
    end
    
    drawnow;  %actualizar la figura
    pause(0.01);  
end

disp(size(emg_data));  %dimensiones arreglo EMG
disp(emg_data(1:10, :));  %primeras 10 muestras de datos capturados

mm.myoData.stopStreaming();
