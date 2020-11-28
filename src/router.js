import Vue from "vue";
import Router from "vue-router";

import Home from "./pages/Home.vue";
import SignIn from "./pages/SignIn.vue";
import Register from "./pages/Register.vue";
import ResetPassword from "./pages/ResetPassword.vue";
import About from "./pages/About.vue";
import UserRides from "./pages/UserRides.vue";

Vue.use(Router);

export default new Router({
  mode: "history",
  base: process.env.BASE_URL,
  routes: [
    { name: "home-page", path: "/", component: Home },
    { name: "sign-in", path: "/sign-in", component: SignIn },
    { name: "register", path: "/register", component: Register },
    { name: "reset-password", path: "/reset-password", component: ResetPassword },
    { name: "about-us", path: "/about-us", component: About },
    { name: "user-rides", path: "/user-rides", component: UserRides }
  ]
});
