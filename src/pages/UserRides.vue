<template>
  <v-container>
    <div>
      <h4 class="display-1">My Rides</h4>

      <v-data-table
        class="elevation-1"
        v-bind:headers="headers"
        v-bind:items="rides"
      >
        <template v-slot:item="{ item }">
          <!-- <tr v-bind:class="itemClass(item)"> -->
          <tr>
            <td>{{ item.departTime }}</td>
            <td>{{ item.toLocation }}</td>
            <td>{{ item.fromLocation }}</td>
            <td>{{ item.vehicle }}</td>
            <td>{{ item.cost }}</td>
            <td>
              <v-icon small @click="deleteRide(item)">
                mdi-delete
              </v-icon>
              <v-icon small class="ml-2" @click="togglePassenger(item)">
                mdi-pencil
              </v-icon>
              <v-icon small class="ml-2" @click="toggleDriver(item)">
                mdi-pencil
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
        { text: "Vehicle", value: "vehicle" },
        { text: "Total Cost", value: "cost" },
        { text: "Action", value: "action" }
      ],
      accounts: [],

      snackbar: {
        show: false,
        text: ""
      }
    };
  },

  mounted: function() {
    this.$axios.get("/rides").then(response => {
      this.rides = response.data.map(ride => ({
        departTime: ride.date,
        fromLocation: ride.fromLocationId,
        toLocation: ride.toLocationId,
        vehicle: ride.vehicleId,
        cost: ride.fee,
      }));
    });
  },

  methods: {
    // Display a snackbar message.
    showSnackbar(text) {
      this.snackbar.text = text;
      this.snackbar.show = true;
    },

    // // Calculate the CSS class for an item
    // itemClass(item) {
    //   const currentAccount = this.$store.state.currentAccount;
    //   if (currentAccount && currentAccount.id === item.id) {
    //     return "currentAccount";
    //   }
    // },

    // // Update account information.
    // updateAccount(item) {
    //   console.log("UPDATE", JSON.stringify(item, null, 2));
    //   this.showSnackbar("Sorry, update is not yet implemented.");
    // },

    // Delete an account.
    deleteRide(item) {
      this.$axios.delete(`/ride/${item.id}`).then(response => {
        if (response.data.ok) {
          // The delete operation worked on the server; delete the local account
          // by filtering the deleted account from the list of accounts.
          this.accounts = this.accounts.filter(
            account => account.id !== item.id
          );
        }
      });
    }
  }
};
</script>

<style>
.currentAccount {
  background: lightcoral;
}
</style>
