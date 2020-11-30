<template>
  <div>
    <h3 class="center">Welcome to Free Rides Only!</h3>

    <p class="center">We hope you're paying</p>

    <v-divider></v-divider>

    <br/>
    
    <v-card>

      <h2 class="center">Search for Rides</h2>
      
      <div class="flex-container">

        <div class="flex-child">
        <v-form>
          <v-text-field
                  class="search"
                  v-bind:style="{
                    'border':`1px solid white`,
                    'width':`100%`,
                    'margin':`0 auto`
                  }" 
                  id="search"
                  label="Type in ride information"
                  name="search"
                  type="search"
          />
        </v-form>
        </div>

        <div class="flex-child">
        <v-card-actions v-if="isLoggedIn">
          <v-btn 
                  class="white--text"
                  v-bind:style="{
                    'float':`right`,
                    'margin':`0 auto`
                  }" 
                  v-on:click="printWords('Congratulations! You clicked on a joke button! :D')" 
                  color="black" 
          >Search
          </v-btn>
        </v-card-actions>
        </div>
      </div>

      <br/>

      <v-data-table
        class="elevation-1"
        v-bind:headers="headers"
        v-bind:items="rides"
      >
        <template v-slot:item="{ item }">
          <!-- <tr v-bind:class="itemClass(item)"> -->
          <tr>
            <td>{{ item.departTime }}</td>
            <td>{{ item.fromLocation }}</td>
            <td>{{ item.toLocation }}</td>
            <td>{{ item.distance }}</td>
            <td>{{ item.vehicle }}</td>
            <td>{{ item.cost }}</td>
            <td>
              <v-icon small class="ml-2" @click="toggleDriver(item)">
                mdi-car
              </v-icon>
              <v-icon small color="blue" class="ml-2" @click="togglePassenger(item)">
                mdi-seat-passenger
              </v-icon>
            </td>
          </tr>
        </template>
      </v-data-table>

      <v-container v-if="isLoggedIn">
      
      <br/><br/>
      
      <h2 class="center">User Information</h2>
      
        <v-btn 
                class="white--text" 
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
      </v-container>
      <!-- <br /> -->
    </v-card>

  </div>
</template>

<script>
export default {
  computed: {
    isLoggedIn() {
      return this.$store.getters.isLoggedIn;
    }
  },

  data() {
    return {
      headers: [
        { text: "Depart Time", value: "departTime" },
        { text: "Origin", value: "fromLocation" },
        { text: "Destination", value: "toLocation" },
        { text: "Distance", value: "distance" },
        { text: "Vehicle", value: "vehicle" },
        { text: "Total Cost", value: "cost" },
        { text: "My Role(s)", value: "roles" }
      ],
      rides: [],
      
      email: "",
      password: "",

      snackbar: {
        show: false,
        msge: "",
      },
    };
  },


      // console.log("departTime: " + response.data.time + " " + response.data.date.substr(0,10));
      // console.log("fromLocationId: " + response.data.fromLocationId);
      // console.log("toLocationId: " + response.data.toLocationId);
      // console.log("distance: " + response.data.distance + " mi.");
      // console.log("vehicleId: " + response.data.vehicleId);
      // console.log("cost: " + response.data.fee);

  mounted: function() {
    this.$axios.get("/rides/2").then(response => {
      this.rides = response.data.map(ride=>({
        departTime: ride.time + " " + ride.date.substr(0,10),
        fromLocation: ride.fromLocationId.name,
        toLocation: ride.toLocationId.name,
        distance: ride.distance + " mi.",
        vehicle: ride.vehicleId,
        cost: ride.fee,
      }));
    });
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

    doSearch(){
      console.log("Other words!");
    },

    printWords(words){
      console.log(words);
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
  .card{
    width:100%;
    padding-bottom:10%;
  }
  .flex-container {
    display: flex;
  }
  .flex-child {
    flex: 1;
  }  
  .flex-child:first-child {
    flex:2;
    margin-left: 10%;
  } 
  /* Code below came from: https://www.w3docs.com/snippets/css/how-to-remove-and-style-the-border-outline-around-text-input-boxes-in-google-chrome.html*/
  
</style>