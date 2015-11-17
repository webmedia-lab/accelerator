<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Accelerator</title>
    </head>
    <body>
        <script>
         var Url = function() {
             var l = window.location;

             var params = {};

             l.search
              .substr(1)
              .split('&')
              .map(function(e){
                  return e.split('=');
              })
              .forEach(function(kv){
                  var k = kv[0];
                  var v = kv[1];
                  params[decodeURIComponent(k)] = decodeURIComponent(v);
              })

             this.params = params;
         }

         var url = new Url();
         var id = url.params.id;
         var ws = new WebSocket('ws://{{IP}}:8080');

         function deviceMotionHandler(e) {
             accel = {id: id, x: e.accelerationIncludingGravity.x, y: e.accelerationIncludingGravity.y, z: e.accelerationIncludingGravity.z }
             ws.send(JSON.stringify(accel));
         }

         if (window.DeviceMotionEvent) {
             console.log('orientation and motion supported');
             window.addEventListener('devicemotion', deviceMotionHandler);
         } else {
             alert('Esto no funciona en este browser')
         }
        </script>
    </body>
</html>
