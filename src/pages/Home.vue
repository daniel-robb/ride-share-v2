<template>
  <div>
    <h3 class="center">Welcome to Free Rides Only!</h3>

    <p class="center">We hope you're paying</p>

    <v-divider></v-divider>

    <br />
    
    <h2 class="center">Search for Rides</h2>
    <br />
    <div class="center">
      <input class="searchbar" type="text" placeholder="Type in ride information">
    </div>

    <br /><br />
    
    <v-card class="card">
      <h2 class="center">User Information</h2>
      <br />
      <div class="card">
        <v-btn class="button" v-bind:to="{ name: 'user-rides' }"> <!--height=280 width=220-->
          <h3>View My Rides</h3>
        </v-btn>
        <v-btn class="button" v-bind:to="{ name: 'register' }"> <!--height=280 width=220-->
          <h3>Register Driver</h3>
        </v-btn>
      </div>
      
    </v-card>
  </div>
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

    getUsers() {
      this.$axios
        .get("/users")
        .then((result) => {
          console.log(result.data);
        })
        .catch((err) => console.log(err));
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
<style>
html, body {height:100%; margin:0;}
  .center{
    float:center;
    text-align:center;
  },
  .searchbar{
    border:10px solid black;
  }
  .button{
    width:50%;
    height:30%;
    background-color: blue;
  }
  .card{
    width:100%;
    padding-bottom:10%;
  }
</style>