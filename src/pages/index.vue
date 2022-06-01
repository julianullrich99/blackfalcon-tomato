<script setup lang="ts">
import Pirat from '~/components/Pirat.vue'
const timeLeft = ref()
const refs = useTemplateRefsList<HTMLImageElement>()

let isPause = $ref(false)
let secondsLeft = $ref<number>()

setInterval(() => {
  const currDate = new Date()
  const currMin = currDate.getMinutes() % 30
  const currSec = currDate.getSeconds()
  isPause = currMin < 30 && currMin >= 25
  timeLeft.value = isPause
    ? `${(4 - (currDate.getMinutes() % 30 - 25)).toString().padStart(2, '0')}:${(59 - currSec).toString().padStart(2, '0')}`
    : `${(24 - currDate.getMinutes() % 30).toString().padStart(2, '0')}:${(59 - currSec).toString().padStart(2, '0')}`

  secondsLeft = +(timeLeft.value.split(':')[0]) * 60 + +(timeLeft.value.split(':')[1])

  refs.value.forEach((e) => {
    e.style.transform = `rotate(${(currSec / 60) * 360 * (isPause ? 20 : 1)}deg)`
  })
}, 1000)
</script>

<template>
  <div class="h-full w-full py-10 flex flex-col" :class="{ 'bg-red-400': isPause, 'bg-green-400': !isPause }">
    <div class="w-full px-36 text-2xl flex justify-evenly items-center text-4xl">
      <img :ref="refs.set" class="h-24 transition-all duration-1000 ease-linear" :class="[isPause && 'h-20rem']" src="/src/assets/falcondev.png" alt="">
      <span :class="[isPause && 'animate-spin']">falconDev IT GmbH <span class="text-sm">und andere</span></span>
      <img :ref="refs.set" class="h-23 transition-all duration-1000 ease-linear" :class="[isPause && 'h-20rem']" src="/src/assets/blackfire.png" alt="">
    </div>
    <div class="w-full h-full flex justify-center items-center text-30rem tabular-nums">
      {{ timeLeft }}
    </div>
    <Pirat :pause="isPause" :time-left="secondsLeft" :time-total="isPause ? 300 : 300 * 5" />
  </div>
</template>

<style>
.rotate {
  animation: rotate 1s infinite;
}

@keyframes rotate {
  0% {
    transform: rotate(0deg)
  }
  100% {
    transform: rotate(360deg)
  }
}
</style>
