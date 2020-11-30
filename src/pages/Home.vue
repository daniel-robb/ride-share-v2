<template>
  <div>
    <h3 class="center">Welcome to Free Rides Only!</h3>

    <p class="center">We hope you're paying</p>

    <v-divider></v-divider>

    <br />
    
    <h2 class="center">Search for Rides</h2>
    <div class="center">
      <input class="input" type="text" placeholder="   Type in ride information">
    </div>

    <br /><br />
    
    <h2 class="center">User Information</h2>
    <div>
      <v-btn 
              class="button white--text" 
              v-bind:style="{
                'width':`50%`, 
                'border':`16px solid #333`, 
                'background-color':`black`
              }" 
              height=320 
              padding-left=100 
              v-bind:to="{ name: 'user-rides' }"
      >
        <h3>View My Rides</h3>
      </v-btn>
      <v-btn 
              class="white--text" 
              v-bind:style="{
                'width':`50%`, 
                'border':`16px solid #333`, 
                'background-color':`black`
              }" 
              height=320 
              v-bind:to="{ name: 'register' }"
      >
        <h3>Register Driver</h3>
      </v-btn>
      <br />
      <br />
    </div>
    
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
  html, body {
    height:100%; 
    margin:0;
    background-color:red;
  }
  .center{
    float:center;
    text-align:center;
  }
  .button{
    width:50%;
    border: 20px solid red;
  }
  .card{
    width:100%;
    padding-bottom:10%;
  }
  /* Code below came from: https://www.w3docs.com/snippets/css/how-to-remove-and-style-the-border-outline-around-text-input-boxes-in-google-chrome.html*/
  .input {
    padding: 5px;
    margin: 5px 0;
    border: 1px solid #010;
  }
  .input:focus,
  .input:active {
    border-bottom: 2px solid #010;
  }
</style>