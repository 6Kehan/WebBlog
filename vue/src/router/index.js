import Vue from "vue"
import VueRouter from "vue-router"

import Login from "@/views/login/Login";
import AdminLogin from "@/views/login/AdminLogin";
import Register from "@/views/login/Register";
import NotFound from "@/views/error-page/NotFound"

import AdminDashboard from "@/views/dashboard/admin/AdminDashboard"
import UserManage from "@/views/manage/UserManage";
import Trading from "@/views/manage/Blog.vue";
import Type from "@/views/manage/Type.vue";
import Comment from "@/views/manage/Comment.vue";


import UserDashboard from "@/views/dashboard/user/UserDashboard";
import Personnal from "@/views/dashboard/Personnal";
import PersonalInfo from "@/views/userInterface/PersonalInfo";
import MyTrading from "@/views/userInterface/MyBlog.vue";
import TradingIndex from "@/views/userInterface/BlogIndex.vue";
import MyComment from "@/views/userInterface/MyComment.vue";
import MyCollect from "@/views/userInterface/MyCollect.vue";
import MyMessage from "@/views/userInterface/MyMessage.vue";
import MyFollow from "@/views/userInterface/MyFollow.vue";
import Detail from "@/views/userInterface/componet/Detail.vue";
import UserDetail from "@/views/userInterface/componet/UserDetail.vue";


Vue.use(VueRouter);

// 解决重复点击路由报错的BUG
const originalPush = VueRouter.prototype.push
VueRouter.prototype.push = function push(location) {
    return originalPush.call(this, location).catch((err) => err)
}

export default new VueRouter({
    mode: 'history',
    routes: [
        {path: '/', component: Login},
        {path: '/login', component: Login,},
        {path: '/adminLogin', component: AdminLogin,},
        {path: '/register',name: 'Register', component: Register,},
        {
            path: '/dashboard/admin', component: AdminDashboard,
            children: [
                {path: '/manage/user', component: UserManage},
                {path: '/manage/blog', component: Trading},
                {path: '/manage/type', component: Type},
                {path: '/manage/comment', component: Comment},
            ]
        }, {
            path: '/dashboard/user', component: UserDashboard,
            children: [
                {path: '/userInterface/tradingIndex', component: TradingIndex,},
                {path: '/userInterface/detail/:id', component: Detail,name: 'Detail'},
                {path: '/userInterface/userDetail/:id', component: UserDetail,name: 'UserDetail'},
            ]
        },
        {
            path: '/personal', component:Personnal,
            children: [
                {path: '/personal/personalInfo', component: PersonalInfo},
                {path: '/personal/myTrading', component: MyTrading,},
                {path: '/personal/myComment', component: MyComment,},
                {path: '/personal/myCollect', component: MyCollect,},
                {path: '/personal/myFollow', component: MyFollow,},
                {path: '/personal/myMessage', component: MyMessage,},
            ]
        },
        {path: '*', component: NotFound}
    ]
});
