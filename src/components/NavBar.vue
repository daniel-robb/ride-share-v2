<template>
  <v-app-bar app dark color="black">
    <router-link v-bind:to="{ name: 'home-page' }">
      <v-toolbar-title class="white--text">
        Free Rides Only
      </v-toolbar-title>
    </router-link>

    <v-spacer></v-spacer>
    <v-btn v-if="!isLoggedIn" text v-bind:to="{ name: 'sign-in' }">
      Sign In
    </v-btn>
    <v-btn text v-bind:to="{ name: 'about-us' }">About Us</v-btn>
  </v-app-bar>
</template>

<script>
export default {
  computed: {
    isLoggedIn() {
      return this.$store.getters.isLoggedIn;
    }
  },
};
</script>
<style>
  div a{
    text-decoration: none;
  }
</style>