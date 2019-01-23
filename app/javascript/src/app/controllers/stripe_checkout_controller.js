import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['form', 'card', 'firstName', 'lastName', 'companyName', 'email', 'tokenInput'];

  connect() {
    this.stripe = Stripe(document.body.dataset.stripeKey);
    const elements = this.stripe.elements({
      fonts: [
        {
          cssSrc: 'https://fonts.googleapis.com/css?family=Poppins',
        },
      ],
    });
    const style = {
      base: {
        iconColor: '#377dff',
        color: '#1e2022',
        fontWeight: 500,
        fontFamily: 'Poppins, Helvetica, Arial, sans- serif',
        fontSize: '16px',
        fontSmoothing: 'antialiased',

        ':-webkit-autofill': {
          color: '#fce883',
        },
        '::placeholder': {
          color: '#949faa',
        },
      },
      invalid: {
        iconColor: '#FFC7EE',
        color: '#FFC7EE',
      },
    };
    const card = elements.create('card', { iconStyle: 'solid', style: style });
    card.mount(this.cardTarget);
    this.registerElements([card]);
  }

  registerElements(elements) {
    // Listen for errors from each Element, and show error messages in the UI.
    const savedErrors = {};
    const error = this.formTarget.querySelector('.error');
    const errorMessage = this.formTarget.querySelector('.message');

    elements.forEach(function(element, idx) {
      element.on('change', function(event) {
        if (event.error) {
          error.classList.add('visible');
          savedErrors[idx] = event.error.message;
          errorMessage.innerText = event.error.message;
        } else {
          savedErrors[idx] = null;

          // Loop over the saved errors and find the first one, if any.
          var nextError = Object.keys(savedErrors)
            .sort()
            .reduce(function(maybeFoundError, key) {
              return maybeFoundError || savedErrors[key];
            }, null);

          if (nextError) {
            // Now that they've fixed the current error, show another one.
            errorMessage.innerText = nextError;
          } else {
            // The user fixed the last error; no more errors.
            error.classList.remove('visible');
          }
        }
      });
    });

    this.formTarget.addEventListener('submit', this.formEventListener.bind(this, elements));
  }

  enableInputs() {
    Array.prototype.forEach.call(
      this.formTarget.querySelectorAll("input[type='text'], input[type='email'], input[type='tel']"),
      function(input) {
        input.removeAttribute('disabled');
      }
    );
  }

  disableInputs() {
    Array.prototype.forEach.call(
      this.formTarget.querySelectorAll("input[type='text'], input[type='email'], input[type='tel']"),
      function(input) {
        input.setAttribute('disabled', 'true');
      }
    );
  }

  triggerBrowserValidation() {
    // The only way to trigger HTML5 form validation UI is to fake a user submit event.
    var submit = document.createElement('input');
    submit.type = 'submit';
    submit.style.display = 'none';
    this.formTarget.appendChild(submit);
    submit.click();
    submit.remove();
  }

  formEventListener(elements, e) {
    e.preventDefault();

    // Trigger HTML5 validation UI on the form if any of the inputs fail validation.
    var plainInputsValid = true;
    Array.prototype.forEach.call(this.formTarget.querySelectorAll('input'), function(input) {
      if (input.checkValidity && !input.checkValidity()) {
        plainInputsValid = false;
        return;
      }
    });

    if (!plainInputsValid) {
      this.triggerBrowserValidation();
      return;
    }

    // Show a loading screen...
    this.formTarget.classList.add('submitting');

    // Disable all inputs.
    this.disableInputs();

    // Gather additional customer data we may have collected in our form.
    var additionalData = {
      first_name: this.firstNameTarget ? this.firstNameTarget.value : undefined,
      last_name: this.lastNameTarget ? this.lastNameTarget.value : undefined,
      company_name: this.companyNameTarget ? this.companyNameTarget.value : undefined,
      email: this.emailTarget ? this.emailTarget.value : undefined,
    };

    // Use Stripe.js to create a token. We only need to pass in one Element
    // from the Element group in order to create a token. We can also pass
    // in the additional customer data we collected in our form.
    this.stripe.createToken(elements[0], additionalData).then(
      function(result) {
        // Stop loading!
        this.formTarget.classList.remove('submitting');
        this.enableInputs();

        if (result.token) {
          // If we received a token, show the token ID.
          this.tokenInputTarget.value = result.token.id;
          this.formTarget.classList.add('submitted');
          this.formTarget.submit();
        }
      }.bind(this)
    );
  }
}
