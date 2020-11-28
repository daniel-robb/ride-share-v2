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
    this.$axios.get("/rides").then(response => {
      console.log(response);
      this.rides = response.data.map(ride => ({
        departTime: ride.time + " " + ride.date.substr(0,10),
        fromLocation: ride.fromLocation.name,
        toLocation: ride.toLocation.name,
        distance: ride.distance + " mi.",
        vehicle: ride.vehicle.make + " " + ride.vehicle.model + " (" + ride.vehicle.color + ")",
        cost: "$" + ride.fee,
      }));
    });
  },

  methods: {
    // Display a snackbar message.
    showSnackbar(text) {
      this.snackbar.text = text;
      this.snackbar.show = true;
    },

    // Delete a ride.
    deleteRide(item) {
      this.$axios.delete(`/rides/${item.id}`).then(response => {
        if (response.data.ok) {
          // The delete operation worked on the server; delete the local ride
          // by filtering the deleted ride from the list of rides.
          this.rides = this.rides.filter(
            ride => ride.id !== item.id
          );
        }
      });
    },

    // Delete a ride.
    togglePassenger(item) {
      console.log("Toggled Passenger status for ride:");
      console.log(item);
    },

    // Delete a ride.
    toggleDriver(item) {
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