function Validator(options) {
  function getParent(element, selector) {
    while (element.parentElement) {
        if (element.parentElement.matches(selector)) {
            return element.parentElement;
        }
        element = element.parentElement;
    }
}


  let selectorRules = {};
    //Hàm thực hiện validate
  function validate(inputElement, rule) {
    let errorElement =
      getParent(inputElement, options.formGroupSelector).querySelector(options.errorSelector);
    var errorMessage;
    //Lấy ra các rule của selector
    let rules = selectorRules[rule.selector];
    //Lọc qua từng rules và kiểm tra. Nếu có lỗi thì dừng kiểm tra.
    for (let i =0; i<rules.length;i++) {
      switch (inputElement.type) {
        case 'radio':
        case 'checkbox':
            errorMessage = rules[i](
                formElement.querySelector(rule.selector + ':checked')
            );
            break;
        default:
            errorMessage = rules[i](inputElement.value);
    }
      if (errorMessage) break;
    }
    if (errorMessage) {
      errorElement.innerHTML = errorMessage;
      getParent(inputElement, options.formGroupSelector).classList.add("invalid");
    } else {
      errorElement.innerHTML = "";
      getParent(inputElement, options.formGroupSelector).classList.remove("invalid");
    }

    return !errorMessage;
  }
  //Lấy element của form
  let formElement = document.querySelector(options.form);
  if (formElement) {
    formElement.onsubmit = function (e) {
      //e.preventDefault();
      let isFormValid = true;
      //Lặp qua từng rule và validate
      options.rules.forEach(function (rule) {
        let inputElement = formElement.querySelector(rule.selector);
        let isValid = validate(inputElement,rule);
        if (!isValid) {
          isFormValid = false;
        }
      });
        if (!isFormValid) {
            e.preventDefault();
            return false;
        }
        else return true;
      // if (isFormValid) {
      //   //Trường hợp submit với JS
      //   if (typeof options.onSubmit === 'function') {
      //     let enableInputs = formElement.querySelectorAll('[name]');
      //     let formValues = Array.from(enableInputs).reduce(function (values, input) {
      //       switch(input.type) {
      //         case 'radio':
      //             values[input.name] = formElement.querySelector('input[name="' + input.name + '"]:checked').value;
      //             break;
      //         case 'checkbox':
      //             if (!input.matches(':checked')) {
      //                 values[input.name] = '';
      //                 return values;
      //             }
      //             if (!Array.isArray(values[input.name])) {
      //                 values[input.name] = [];
      //             }
      //             values[input.name].push(input.value);
      //             break;
      //         case 'file':
      //             values[input.name] = input.files;
      //             break;
      //         default:
      //             values[input.name] = input.value;
      //     }
      //
      //     return values;
      // }, {});
      //     options.onSubmit(formValues);
      //   } else {
      //     formElement.submit();
      //   }
      // }
    }

    //Lặp qua mỗi rule và xử lý
    options.rules.forEach(function (rule) {
      //Lưu lại các rules cho mỗi input
      if (Array.isArray(selectorRules[rule.selector])) {
        selectorRules[rule.selector].push(rule.test);
      } else {
        selectorRules[rule.selector] = [rule.test];
      }

      let inputElements = formElement.querySelectorAll(rule.selector);

      Array.from(inputElements).forEach(function (inputElement) {
         // Xử lý trường hợp blur khỏi input
          inputElement.onblur = function () {
              validate(inputElement, rule);
          }

          // Xử lý mỗi khi người dùng nhập vào input
          inputElement.oninput = function () {
              var errorElement = getParent(inputElement, options.formGroupSelector).querySelector(options.errorSelector);
              errorElement.innerText = '';
              getParent(inputElement, options.formGroupSelector).classList.remove('invalid');
          }
      });
  });
}

}

Validator.isRequired = function (selector, message) {
  return {
    selector: selector,
    test: function (value) {
      return value.trim() ? undefined : message|| "Vui lòng nhập trường này";
    },
  };
};
Validator.isEmail = function (selector, message) {
  return {
    selector: selector,
    test: function (value) {
        let regex = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
        return regex.test(value) ? undefined : message|| 'Trường này phải là email.'
    },
  };
};
Validator.minLength = function (selector, min,message) {
    return {
      selector: selector,
      test: function (value) {
          return value.length >= min ? undefined: message|| `Vui lòng nhập tối thiểu ${min} kí tự`;
      },
    };
  };
  Validator.isConfirmed = function (selector, getConfirmValue, message) {
    return {
      selector: selector,
      test: function (value) {
        return value === getConfirmValue() ? undefined : message|| 'Giá trị nhập vào không chính xác';
      }
    }
  }