/*
Require: axmier, pulseaudio (pactl, pacmd), head, sed, grep

Script to set up/down the volume with pulseaudio audio server
*/

const { exec } = require('child_process');

let mode = process.argv[2] === undefined ? "UP" : process.argv[2]

exec("amixer sget Master | grep -oP '([0-9]+)%' | head -n 1 | sed s/%//", (err, stdout) => {
  let volume = parseInt(stdout)
  exec("pacmd list-sinks | grep '*'", (err, stdout, stderr) => {
    const re = /[0-9]+/g
    let index = parseInt(re.exec(stdout)[0])
    let newVolume = 0
    if (volume >= 100) {
      if (mode === "UP") {
        newVolume = "100%"
      } else {
        newVolume = "-5%"
      }
    } else {
      if (mode === "UP") {
        newVolume = "+5%"
      } else {
        newVolume = "-5%"
      }
    }

    console.log(`mode: ${mode}, device: ${index}, old: ${volume}, new: ${newVolume}`)

    let cmd = "pactl set-sink-volume " + index + " " + newVolume

    exec(cmd)
  })
})
