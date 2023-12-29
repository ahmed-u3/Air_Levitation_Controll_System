clear a;
a = arduino('COM4', 'Uno');

   for i = 1:10
      writeDigitalPin(a, 'D13', 0);
      pause(5);
      writeDigitalPin(a, 'D13', 1);
      pause(5);
   end
