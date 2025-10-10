
// 定义引脚名称，让代码更容易阅读
const int buttonPin = 13; // 按钮连接到 GP14 这里弄错了 得自己读取
const int ledPin = 5;    // LED 连接到 GP15

void setup() {
  // 设置 LED 引脚为输出模式
  pinMode(ledPin, OUTPUT);
  
  // 设置按钮引脚为输入模式，并启用内部上拉电阻
  // 内部上拉电阻会将引脚默认拉高 (HIGH)。
  // 当按钮按下时，引脚被连接到 GND (LOW)。
  pinMode(buttonPin, INPUT_PULLUP);
}

void loop() {
  // 读取按钮的状态
  int buttonState = digitalRead(buttonPin);

  // 因为我们使用了 INPUT_PULLUP，所以:
  // 如果 buttonState 是 LOW (0)，表示按钮被按下
  if (buttonState == LOW) {
    // 按钮被按下: 打开 LED
    digitalWrite(ledPin, HIGH);
  } else {
    // 按钮被释放 (buttonState 是 HIGH): 关闭 LED
    digitalWrite(ledPin, LOW);
  }

  // 小延迟，防止 CPU 过快循环，但对于这种简单的任务，可以省略或保持很小的值。
  // delay(5); 
}
