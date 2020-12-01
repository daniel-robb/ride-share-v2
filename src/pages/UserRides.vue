<template>
  <v-container>
    <div>
      <h4 class="center display-1">My Rides</h4>

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

      <v-snackbar v-model="snackbar.show">
        {{ snackbar.text }}
        <v-btn color="blue" text @click="snackbar.show = false">
          Close
        </v-btn>
      </v-snackbar>
    </div>
  </v-container>
</template>

<script>
export default {
  name: "UserRides",

  data: function() {
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

      snackbar: {
        show: false,
        text: ""
      }
    };
  },

  mounted: function() {
    const email = this.$store.getters.getEmail;
    let userId;

    this.$axios.get("/users")
        .then(response => {
          response.data.forEach(async (user) => {
            if (user.email == email) { //Found the logged-in user
              userId = user.id;
              // console.log(userId);
            }
          });
        })
        .catch((err) => this.showDialog("Failed", err));


    this.$axios.get("/rides").then(async response => {
      let userRides = [];
      
      let passengers;
      await this.$axios.get("/passengers")
        .then(passengerResponse => {
          passengers = passengerResponse.data; //Store all passenger associations in "passengers"
        });
      
      let drivers;
      let driverId = undefined;
      let driverRides;
      await this.$axios.get("/drivers")
        .then(driversResponse => { drivers = driversResponse.data; }); //Store all drivers in "drivers"

      drivers.forEach(driver => { 
        if (driver.userId == userId) {
          // console.log(driver);
          driverId = driver.id;
        }
      });

      driverRides = await this.$axios.get(`/rides-by-driver/${driverId}`);

      driverRides.data.forEach(async driver_ride => { //Add each ride the user is driving on to userRides
        let ride;
        await this.$axios.get(`/rides/${driver_ride.rideId}`) //This is not being waited for, and is thus not displaying in the table
          .then(result => ride = result.data);
        // console.log(ride);
        userRides.push(ride);
      });

      response.data.forEach(ride => { //Loop through all rides
        passengers.forEach(passenger => { //And passengers
          if (passenger.rideId == ride.id && passenger.user.email == email) {
            //Check if the passenger is on the current ride, and if it is the user currently logged in
            userRides.push(ride); //If it is, add the ride to userRides, which will be displayed in the table
          }
        });
      });
      
      // console.log("userRides:")
      // userRides.forEach(ride => {
      //   console.log(ride);
      // });

      let temp='$';
      //Map all appropriate rides into the table
      this.rides = userRides.map(ride => ({
        departTime: ride.time + " " + ride.date.substr(0,10),
        fromLocation: ride.fromLocation.name,
        toLocation: ride.toLocation.name,
        distance: ride.distance + " mi.",
        vehicle: ride.vehicle.make + " " + ride.vehicle.model + " (" + ride.vehicle.color + ")",
        cost: temp + ride.fee,
      }));
    });
  },

  methods: {
    // Display a snackbar message.
    showSnackbar(text) {
      this.snackbar.text = text;
      this.snackbar.show = true;
    },

    // If user is a passenger on this ride, make them no longer a passenger.
    // If they were not a passenger, make them one.
    togglePassenger(item) { //NOT IMPLEMENTED
      console.log("Toggled Passenger status for ride:");
      console.log(item);
    },

    // Same as togglePassenger(), but for driver status
    toggleDriver(item) { //NOT IMPLEMENTED
      console.log("Toggled Driver status for ride:");
      console.log(item);
    }
  }
};
</script>

<style>
  .ml-2 {
    color:blue;
  }
</style>