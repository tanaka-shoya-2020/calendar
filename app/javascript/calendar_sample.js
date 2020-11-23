// if (document.URL === 'http://localhost:3000/samples/new') {
  function input (){

    const start_year = document.getElementById("_start_time_1i");
    const start_month = document.getElementById("_start_time_2i");
    const start_day = document.getElementById("_start_time_3i");
    
    const end_year = document.getElementById("_end_time_1i");
    const end_month = document.getElementById("_end_time_2i");
    const end_day = document.getElementById("_end_time_3i");

    end_year.value = start_year.value
    end_month.value = start_month.value
    end_day.value = start_day.value

    start_year.addEventListener("change", () => {
      end_year.value = start_year.value
    })
    start_month.addEventListener("change", () => {
      end_month.value = start_month.value
    })
    start_day.addEventListener("change", () => {
      end_day.value = start_day.value
    })

    end_year.addEventListener("change", () => {
      start_year.value = end_year.value
    })
    end_month.addEventListener("change", () => {
      start_month.value = end_month.value
    })
    end_day.addEventListener("change", () => {
      start_day.value = end_day.value
  })
  }
  setInterval(input, 1000);
// }