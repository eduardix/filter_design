%% INICIALIZA. Abre el archivo de sonido
clear all 
close all

% Observe los comandos utilizados 
[y, Fs, nbits, opts] = wavread('hal9000.wav');
player = audioplayer(y,Fs);
play(player)
y = y(:,1);

figure,
t = linspace(0,length(y)/Fs,length(y));
subplot(2,1,1), plot(t,y);
title('Forma de onda (canal izquierdo)');
xlabel('Tiempo (s)');
ylabel('Amplitud');
box on
grid on
axis([0 t(end) -1 1]);

%Recortamos un fragmento para que no sea tan largo:
y = y(300000:495000,:);
t = linspace(300000./Fs,(300000+length(y))./Fs,length(y));
subplot(2,1,2), plot(t,y);
title('Forma de onda (canal izquierdo)');
xlabel('Tiempo (s)');
ylabel('Amplitud');
box on
grid on
axis([t(1) t(end) -1 1]);

%% 1. Reproduce
player = audioplayer(y,Fs);
play(player)
%% 2. Espectro de la secuencia y espectrograma

%Ver función "show_especto" para comprender entrada y salida
param.nfft = 1024;%Entre 128 y 4096
param.anchura_ventana = param.nfft;%Entre 128 y 4096
param.noverlap = 0; %Preguntar al profesor.
param.fs = Fs;

%Representa el espectro
[h,Y,output] = show_espectro(y,param);

%% 3: Diezmado

N = 2; %Orden
yn = downsample(y,N);   %La longitud de la secuencia se divide por N
fs = Fs/N;                 %Cambio en la Fs
param.fs = fs;

%Representa espectro:
param.nfft = 1024;%Entre 128 y 4096
param.anchura_ventana = param.nfft;%Entre 128 y 4096
param.noverlap = 0; %Preguntar al profesor.
param.fs = fs;

[h,Y,output] = show_espectro(yn,param);

%Reproduce la secuencia
player = audioplayer(yn,fs);
play(player)

%% 4: Diseñamos el filtro
% i)    Llamar a fdatool
% ii)   Diseñe el filtro y guarde la sesión cuando quiera.
% iii)  Exporte el filtro al Workspace en forma de objeto, y llámelo "Hd".
%% 5: Aplicamos el filtro y representamos espectro y espectrograma

% Filtro
z = filter(Hd, yn);

%Reproduzca
player = audioplayer(z,fs);
play(player)

% Representación de la señal filtrada
param.nfft = 1024;%Entre 128 y 4096
param.anchura_ventana = param.nfft;%Entre 128 y 4096
param.noverlap = 0; %Preguntar al profesor.
param.fs = fs;

[h,Y,output] = show_espectro(z,param);

%% 6: 

N2 = 3; %Orden
zn = downsample(z,N2);   %La longitud de la secuencia se divide por N
fs2 = fs/N2;          %Cambio en la Fs

player = audioplayer(zn,fs2);
play(player)

% Representación de la señal filtrada
param.nfft = 1024;%Entre 128 y 4096
param.anchura_ventana = param.nfft;%Entre 128 y 4096
param.noverlap = 0; %Preguntar al profesor.
param.fs = fs2;

[h,Y,output] = show_espectro(zn,param);
