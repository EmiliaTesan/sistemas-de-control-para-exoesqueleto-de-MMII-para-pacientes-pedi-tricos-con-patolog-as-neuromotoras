function vergrabacion(nombre_archivo)
    data = readmatrix(nombre_archivo);

    disp(data(1:5,:));%primeras 5 filas de los datos
    %primera columna es tiempo
    %desde 2 a 9 son 8 canales de EMG
    %desde 10 a 12 giroscopio XYZ
    %desde 13 a 15 acelerometro XYZ

    figure;
    plot(data(:,1), data(:,2:9)); %primer columna es tiempo
    title('senial EMG');
    xlabel('tiempo [seg]');
    ylabel('amplitud de EMG');
    legend('canal 1', 'canal 2', 'canal 3', 'canal 4', 'canal 5', 'canal 6', 'canal 7', 'canal 8');

    %giroscopio y acelerometro
    figure; subplot(2,1,1); plot(data(:,1), data(:,10:12)); 
    title('giroscopio');
    xlabel('tiempo [seg]'); ylabel('valor del giroscopio'); legend('X', 'Y', 'Z');

    subplot(2,1,2); plot(data(:,1), data(:,13:15)); 
    title('acelerometro'); 
    xlabel('tiempo [seg]'); ylabel('valor del acelerometro'); legend('X', 'Y', 'Z');
end
