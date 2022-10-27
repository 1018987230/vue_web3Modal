import { createRouter,createWebHistory } from "vue-router";

const router = createRouter({
    history: createWebHistory(),
    mode:'history',
    routes: [

        
        {
            path: '/',
            name: 'home',
            component: () => import(/*webpackChunkName: "home" */ '../views/home.vue')
        },
        
        

    ]
})
export default router