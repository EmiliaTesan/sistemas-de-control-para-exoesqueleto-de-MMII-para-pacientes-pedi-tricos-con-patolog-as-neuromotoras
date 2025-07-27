mm.myoData.startStreaming();
pause(1);  

emg_data = [];  %inicializar variable de almacenamiento EMG
for i = 1:100  %100 muestras
    pause(0.01); 
    emg_data = [emg_data; mm.myoData.emg];  %agregar muestra al arreglo
end

disp(size(emg_data))  %esperado: [100, 8] (100 muestras de los 8 canales)
emg_data = double(emg_data);% convertir a double para no tener problemas de escala

%verificar datos cambiando (comparando las primeras 10 muestras)
disp(emg_data(1:10, :))  %verificar valores cambian al mover el brazo

%graficar EMG
figure;
for ch = 1:8  
    subplot(8,1,ch);  %subgráfica por canal
    plot(emg_data(:, ch));  
    title(['canal ' num2str(ch)]);  
    ylim([-0.3 0.3]);  %rango chiquito para mejor visibilidad (para manuel probablemente <)
end