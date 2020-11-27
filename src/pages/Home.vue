<template>
  <v-container>
    <div>
      <h4 class="display-1">Welcome to Free Rides Only!</h4>

      <p class="body-1">We hope you're paying</p>

      <!-- <SearchBar v-model="searchQuery" /> -->

      <!-- <SearchBar hint="search hint" :text="searchPhrase" @textChange="onTextChanged" @submit="onSubmit" /> -->

      <v-divider></v-divider>

      <br /><br />
      
      <h2>Search for Rides</h2>
      <br />
      <div class="searchbar">
        <input type="search" placeholder="Type in ride information">
      </div>

      <br /><br /><br /><br />
      
      <v-card>
        <h2 >User Information</h2>
        <br />
        <span>
          <v-btn v-on:click="helloWorld" height=280 width=220><!--v-on:click="handleSubmit"-->
            <h3>View My Rides</h3>
          </v-btn>
          <v-btn v-on:click="helloWorld" height=280 width=220><!--v-on:click="handleSubmit"-->
            <h3>Register Driver</h3>
          </v-btn>
        </span>
      </v-card>
    </div>
  </v-container>
</template>

<script>
export default {
  data() {
    return {
      email: "",
      password: "",

      snackbar: {
        show: false,
        msge: "",
      },
    };
  },

  methods: {
    logIn() {
      this.$axios
        .post("/login", {
          email: this.email,
          password: this.password,
        })
        .then((result) => {
          this.showSnackbar(result.data.msge);
          if (result.data.ok) {
            this.$store.commit("logIn", result.data.details);
            this.$router.push({ name: "home-page" });
          }
        })
        .catch((err) => this.showSnackbar(err));
    },

    showSnackbar(msge) {
      this.snackbar.msge = msge;
      this.snackbar.show = true;
    },

    helloWorld() {
      console.log("Words!");
    },
  },
};
</script>