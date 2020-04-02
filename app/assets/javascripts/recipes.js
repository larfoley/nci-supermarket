// (function() {
//
//   class Meal {
//     constructor(name, img, src) {
//       this.name = name
//       this.img = img
//       this.src = src
//     }
//
//     render() {
//       const { name, img, src } = this;
//       return `
//         <li class="meal__item">
//           <a href="${src ? src : "#"}" class="meal__link">
//             <img src="${img}" />
//           </a>
//           <div class="meal__body">
//             ${name}
//           </div>
//         </li>
//       `
//     }
//   }
//
//   class TheMealsDBAdapter {
//     constructor() {
//       this.baseUrl = 'https://www.themealdb.com/api/json/v1/'
//       this.apiKey = '1'
//     }
//
//     async findAll() {
//       const response = await fetch(`${this.baseUrl + this.apiKey}/search.php?s=`)
//       const { meals } = await response.json()
//       return meals
//         .map(({ strMeal, strMealThumb, strSource }) => new Meal(strMeal, strMealThumb, strSource))
//         .reduce((html, meal) => html += meal.render(), '');
//     }
//   }
//
//   class SpoonacularAdapter {
//     constructor() {
//       this.baseUrl = 'https://api.spoonacular.com/'
//       this.apiKey = 'bc8819d1c26440c1ac04d4504940fe04'
//     }
//
//
//     buildImageURL(id) {
//       return `https://spoonacular.com/recipeImages/${id}-556x370.jpg?`
//     }
//
//     async findAll() {
//       const mealsResponse = await fetch(`${this.baseUrl}/recipes/search?apiKey=${this.apiKey}`)
//       const { results } = await mealsResponse.json()
//       const meals = []
//
//       for (let meal of results) {
//         const mealDetailsResponse = await fetch(`${this.baseUrl}/recipes/${meal.id}/information?includeNutrition=false&&apiKey=bc8819d1c26440c1ac04d4504940fe04`)
//         meals.push(await mealDetailsResponse.json())
//       }
//
//       await Promise.all(meals)
//
//       return meals
//         .map(({ title, id,  sourceUrl }) => new Meal(title, this.buildImageURL(id), sourceUrl))
//         .reduce((html, meal) => html += meal.render(), '');
//     }
//   }
//
//   function renderHTML(html) {
//     const outputElement = document.querySelector('.meal__list');
//
//     if (outputElement === null) return
//
//     outputElement.innerHTML = html
//   }
//
//   window.addEventListener('load', async function () {
//     const theMealsDBAdapter = new TheMealsDBAdapter()
//     const spoonacularAdapter = new SpoonacularAdapter()
//
//     let html = ""
//
//     try {
//       html += await theMealsDBAdapter.findAll()
//       html += await spoonacularAdapter.findAll()
//
//       renderHTML(html)
//
//     } catch (e) {
//       renderHTML('Unable to load recipies try again later. Check console for error')
//       console.log(e);
//     }
//   })
//
// })()
