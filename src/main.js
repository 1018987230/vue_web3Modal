import { createApp } from 'vue'
import ElementPlus from 'element-plus'
import 'element-plus/dist/index.css'
import router from './router'


// 视频插件
import 'video.js/dist/video-js.css' 
import 'vue-video-player/src/custom-theme.css'
import App from './App.vue'

const app = createApp(App)

// app.use(ElementPlus)
app.use(router)
app.mount('#app')


