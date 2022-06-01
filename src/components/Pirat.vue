<script lang="ts" setup>
const props = defineProps<{
  pause: boolean
  timeLeft: number
  timeTotal: number
}>()

enum DIRECTIONS {
  left = 'left',
  right = 'right',
}

const imageRef = $ref<HTMLImageElement>()

const images = [
  'arrrrrr.png',
  'erika.png',
  'kek.png',
  'Luuuuu.png',
  'piewwarrrrrr.png',
]

let direction: DIRECTIONS = DIRECTIONS.left
let imgSrc = $ref<String>()

const showImage = () => {
  imgSrc = images[Math.floor(Math.random() * images.length)]
  direction = Math.random() >= 0.5 ? DIRECTIONS.left : DIRECTIONS.right
}

const animateImage = () => {
  const int: any = setInterval(() => {
    if (!props.pause)
      return clearInterval(int)

    const percentageLeft = props.timeLeft / props.timeTotal
    const margin = (window.innerWidth - imageRef.clientWidth) * percentageLeft

    imageRef.style.transform = `translateX(${direction === DIRECTIONS.left ? margin : (window.innerWidth - imageRef.clientWidth - margin)}px) ${direction === DIRECTIONS.right ? 'scaleX(-1)' : ''}`
    // imageRef.style.transform = `translateX(${margin}px)`
  }, 1000 / 60)
}

watch(() => props.pause, () => {
  if (props.pause) {
    showImage()
    animateImage()
  }
}, { immediate: true })
</script>

<template>
  <div v-if="pause" class="absolute h-screen w-full top-0">
    <img ref="imageRef" class="h-1/2 bottom-0 absolute transition-all duration-1000 ease-linear" alt="" :src="imgSrc as string">
  </div>
</template>
