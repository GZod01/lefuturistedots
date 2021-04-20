const { exec } = require('child_process');

class AudioAdapter {
  fetchDevices() {
    return new Promise((resolve, reject) => {
      exec("pacmd list-sinks | grep -E 'index:|name:'", (err, stdout, stderr) => {
        if (err != null) {
          return reject(err)
        }
        if (stderr != '') {
          return reject(stderr)
        }

        const regex = /(\*|) index: ([0-9])\n\tname: <alsa_output.([a-z A-Z_\-0-9.]+).analog-stereo/gm;
        let devices = []
        let match
        while ((match = regex.exec(stdout)) !== null) {
          devices.push({
            id: parseInt(match[2]),
            name: match[3],
            selected: match[1] == "*"
          })
        }
        return resolve(devices)
      });
    })
  }

  switchToDevice(deviceId) {
    return new Promise((resolve, reject) => {
      // switch default
      exec("pacmd set-default-sink " + deviceId, (err, stdout, stderr) => {
        if (err != null) {
          return reject(err)
        }
        if (stderr != '') {
          return reject(stderr)
        }
        // switch apps
        // get output applications
        exec(`pacmd list-sink-inputs | awk '/index:/{print $2}'`, (err, stdout, stderr) => {
          if (err != null) {
            return reject(err)
          }
          if (stderr != '') {
            return reject(stderr)
          }
          // for each apps, change the output device
          stdout.split('\n').filter(d => d != '').forEach(appId => {
            appId = parseInt(appId)          
            exec(`pacmd move-sink-input ${appId} ${deviceId}`, (err, stdout, stderr) => {            
              if (err != null) {
                return reject(err)
              }
              if (stderr != '') {
                return reject(stderr)
              }
              return resolve()
            })
          })
        })
      })
    })
  }
}

let audio = new AudioAdapter()

audio.fetchDevices().then((devices) => {
    let toSwitch = devices.filter(device => !device.selected)[0]

  audio.switchToDevice(toSwitch.id)
})

