#include <myo.h>

// Pines BTS7960
const int R_EN = 25;
const int L_EN = 26;
const int RPWM = 18;
const int LPWM = 19;

// Canales PWM
const int PWM_CH_R = 0;
const int PWM_CH_L = 1;

// Instancia del brazalete Myo
armband myo;

void setup() {
  Serial.begin(115200);

  // Configurar pines del puente H
  pinMode(R_EN, OUTPUT);
  pinMode(L_EN, OUTPUT);
  digitalWrite(R_EN, HIGH);
  digitalWrite(L_EN, HIGH);

  // Configurar PWM
  ledcSetup(PWM_CH_R, 5000, 8);
  ledcAttachPin(RPWM, PWM_CH_R);
  ledcSetup(PWM_CH_L, 5000, 8);
  ledcAttachPin(LPWM, PWM_CH_L);

  // Motor detenido al inicio
  detenerMotor();
}

void loop() {
  if (!myo.connected) {
    conectarMyo();
  }
  delay(10);
}

// Conexión a Myo y configuración de IMU
void conectarMyo() {
  Serial.println("Conectando Myo...");
  myo.connect();
  Serial.println("Myo conectada.");
  delay(100);

  myo.set_myo_mode(myohw_emg_mode_none,
                   myohw_imu_mode_send_data,
                   myohw_classifier_mode_disabled);

  myo.imu_notification(TURN_ON)->registerForNotify(myoCallback);
}

// Callback que analiza la orientación y acciona el motor
void myoCallback(BLERemoteCharacteristic *pChar, uint8_t *pData, size_t length, bool isNotify) {
  myohw_imu_data_t *imu = (myohw_imu_data_t *)pData;

  float verde = imu->orientation.z;
  float azul = imu->orientation.x;
  float distancia = abs(verde - azul);

  if (distancia <= 2500) {
    Serial.println("REPOSO");
    detenerMotor();
  } else {
    if (verde > azul) {
      Serial.println("ADELANTE");
      girarAntihorario();
    } else {
      Serial.println("ATRÁS");
      girarHorario();
    }
  }
}

// Giro en sentido antihorario (adelante)
void girarAntihorario() {
  ledcWrite(PWM_CH_R, 50);  // canal derecho activo
  ledcWrite(PWM_CH_L, 0);   // canal izquierdo apagado
}

// Giro en sentido horario (atrás)
void girarHorario() {
  ledcWrite(PWM_CH_R, 0);
  ledcWrite(PWM_CH_L, 50);  // canal izquierdo activo
}

// Detener motor
void detenerMotor() {
  ledcWrite(PWM_CH_R, 0);
  ledcWrite(PWM_CH_L, 0);
}
