<template>
  <v-container>
    <div>
      <h4 class="display-1">Register as a Driver</h4>

      <instructions details="Become a registered Free Rides Only driver with just three easy steps!" />

      <v-form v-model="valid">
        <v-text-field
          v-model="newDriver.email"
          v-bind:rules="rules.email"
          error-count="10"
          label="Email Address"
        ></v-text-field>

        <v-text-field
          v-model="newDriver.licenseNum"
          v-bind:rules="rules.licenseNum"
          label="Driver's License Number"
        ></v-text-field>

        <v-text-field
          v-model="newDriver.licenseState"
          v-bind:rules="rules.required"
          label="Driver's License State"
        ></v-text-field>

        <v-btn v-bind:disabled="!valid" v-on:click="handleSubmit"
          >Register
        </v-btn>
      </v-form>

      <div class="text-xs-center">
        <v-dialog v-model="dialogVisible" width="500">
          <v-card>
            <v-card-title primary-title>
              {{ dialogHeader }}
            </v-card-title>

            <v-card-text>
              {{ dialogText }}
            </v-card-text>

            <v-divider></v-divider>

            <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn color="primary" text v-on:click="hideDialog">Okay</v-btn>
            </v-card-actions>
          </v-card>
        </v-dialog>
      </div>
    </div>
  </v-container>
</template>

<script>
import Instructions from "../components/Instructions.vue";

export default {
  name: "RegisterPage",
  components: {
    Instructions, // Use the Instructions component we just imported
  },
  data: function () {
    return {
      valid: false, // Are all the fields in the form valid?

      // Object to collect account data
      newDriver: {
        email: "",
        licenseNum: "",
        licenseState: "",
      },

      // Was the driver registered successfully?
      registrationSuccessful: false,

      // Data to be displayed by the dialog.
      dialogHeader: "<no dialogHeader>",
      dialogText: "<no dialogText>",
      dialogVisible: false,

      // Validation rules for the form fields. This functionality is an extension
      // that's part of the Vuetify package. Each rule is a list of functions
      // (note the fat arrows). Vuetify invokes all functions in the list,
      // passing it the content of the associated form field. Functions should
      // return either true (the field passes that validation) or a string
      // containing an error message indicating why the field doesn't pass validation.
      rules: {
        required: [(val) => val.length > 0 || "Required"],
        email: [
          (val) => /\w{3,}@\w{3,}(?:.\w{3,})+$/.test(val) || "Invalid e-mail"
        ],
        licenseNum: [
          (val) => /[a-zA-Z0-9]{1,16}/.test(val) || "Invalid license number"
        ],
        licenseState: [
          (val) => val.length == 2 || "Invalid state abbreviation"
        ],
      },
    };
  },
  methods: {
    // Invoked when the user clicks the 'Sign Up' button.
    handleSubmit: function () {
      // Haven't been successful yet.
      this.registrationSuccessful = false;

      this.$axios
        .get("/users")
        .then(response => {
          console.log(this.$store.getters.getEmail);

          response.data.forEach(async (user) => {
            if (user.email == this.newDriver.email) { //The specified email does in fact belong to a user
              const result = await this.$axios
                .post("/drivers", {
                  userId: user.id,
                  licenseNumber: this.newDriver.licenseNum,
                  licenseState: this.newDriver.licenseState,
                })
                .catch((err) => this.showDialog("Failed", err));

                if (result.data.ok == true) {
                  this.showDialog("Success", `${this.newDriver.email} is now a Free Rides Only driver`);
                  this.registrationSuccessful = true;
                } else {
                  this.showDialog("Sorry", `${this.newDriver.email} is already registered as a driver`);
                }
            }
          });
        }).catch((err) => this.showDialog("Failed", err));
    },

    // Helper method to display the dialog box with the appropriate content.
    showDialog: function (header, text) {
      this.dialogHeader = header;
      this.dialogText = text;
      this.dialogVisible = true;
    },

    // Invoked by the "Okay" button on the dialog; dismiss the dialog
    // and navigate to the home page.
    hideDialog: function () {
      this.dialogVisible = false;
      if (this.registrationSuccessful) {
        // Only navigate away from the sign-up page if we were successful.
        this.$router.push({ name: "home-page" });
      }
    },
  },
};
</script>
