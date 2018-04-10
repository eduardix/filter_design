function [h,X,output] = show_espectro(x,param)
    
%Función que calcula el espectro de una secuencia y su espectrograma

% Observe la entrada y los parámetros:
%
% "anchura_ventana": define el tamaño, en número de muestras,de w[m], ventana. 
% "noverlap":        es el número de muestras en cada segmento que se superponen.
% "nfft":            es el número de puntos de la fft. Recuérdese que el número de
%                    puntos debe ser potencia de dos para sacar provecho de los 
%                    algoritmos fft.
% "Fs":              es la frecuencia de muestreo del archivo que se ha abierto
% "x":               es la señal de entrada
%
% Observe la salida de la función:
%
% "S": es la transformada de fourier en tiempo corto. Cada columna de S contiene
%      una estima en "nfft" puntos del espectro de la señal para un tiempo determinado.
% "P": es la densidad espectral de potencia para cada segmento.
% "T": son las rodajas de tiempo
% "F": son las "nfft" frecuencias analizadas 
% Eduardo del Arco 2013-2018
% eduardo.delarco@urjc.es

    %fft
    X = fft(x(:,1),param.nfft);
    f = param.fs/2*linspace(0,1,param.nfft/2+1);
    P2 = abs(X/param.nfft);
    P1 = P2(1:param.nfft/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    
    %spectrogram
    [output.S, output.F, output.T, output.P] = spectrogram(x,param.anchura_ventana,param.noverlap,param.nfft,param.fs);
    S2 = abs(output.S./(param.nfft/2+1))./2;
    
    %Representa:
    h = figure;
    
    subplot(2,2,1), semilogx(1./(f*3600),P1);
    xlabel('Period (hours)');
    ylabel('|X(f)|)');
    box on 
    grid on
    
    subplot(2,2,3), semilogx(f,P1);
    xlabel('Frecuency (Hz)');
    ylabel('|X(f)|');
    box on 
    grid on
    
    subplot(2,2,[2 4]), surf(output.T,output.F,10*log10(S2),'edgecolor','none'); axis tight;
    view(0,90)
    xlabel('Time (s)'); ylabel('Frecuency (Hz)');
    box on
    colorbar('northoutside')
    
    output.f = f;
end