
# Quiz App Documentation

## SplashScreen

The **SplashScreen** widget serves as an introductory screen for the quiz app, displaying a welcome message along with a background image. It also includes a button that navigates to the **QuizScreen** when clicked.

### Functionality:
- **Background Image**:  
  The screen displays a full-screen background image using `BoxDecoration` with `AssetImage`. The image is displayed with `BoxFit.cover`, ensuring it fills the entire screen while maintaining the aspect ratio.
  
- **Welcome Message**:  
  A centered `Text` widget displays the message "Welcome to Quiz App!". The text is styled to be bold, large (28px), and white with a shadow effect to make it stand out against the background.
  
- **Start Quiz Button**:  
  Below the welcome message, there is an `ElevatedButton` labeled "Start Quiz". The button has a blue background, padding, and rounded corners. When pressed, it navigates to the **QuizScreen** using `Navigator.pushReplacement`. This method ensures that the splash screen is replaced by the quiz screen, preventing the user from going back to the splash screen after starting the quiz.

### Features:
- **Decoration and Styling**:  
  The background image enhances the visual appeal of the splash screen. Additionally, the shadow effect on the text improves its readability against the background.
  
- **Navigation**:  
  Upon pressing the "Start Quiz" button, the app navigates to the **QuizScreen**, ensuring a smooth and seamless user experience.

---

## QuizScreen

The **QuizScreen** widget implements a dynamic quiz interface. It uses the **QuizController** to manage quiz data, such as fetching questions and storing user responses. Upon initialization, the quiz data is fetched asynchronously, and a loading indicator (CircularProgressIndicator) is displayed until the data is ready. The app provides a horizontally scrollable navigation bar to switch between questions and updates the UI based on the currently selected question. Users can select answers via checkboxes, and their selections are stored in the **QuizController**. When the "Submit" button is clicked, the answers are evaluated to calculate the number of correct and incorrect responses, and the results are passed to the **ScoreScreen**.

---

## QuizController

The **QuizController** class manages the quiz data and user responses. It has two main functions: **fetchQuizData** and **evaluateAnswers**.

### Functions:
- **fetchQuizData**:  
  This function makes an HTTP GET request to an API (using the `http` package) to fetch quiz data in JSON format. The data contains a list of questions and their respective options. Upon successful retrieval, the questions list is populated, and the `userAnswers` list is initialized with false values (indicating no options are selected initially).
  
- **evaluateAnswers**:  
  This function evaluates the user's selected answers by comparing them to the correct answers (marked by `is_correct: true`). For each correctly answered question, the score is increased by 4 points; for incorrect answers, the score is penalized by 1 point. The final results, including the number of correct and incorrect answers, are returned in a map.

### Plugins Used:
- **http**: Used to make HTTP requests to fetch quiz data from an API.
- **dart:convert**: Used to decode the JSON response from the API into a usable format.

---

## ScoreScreen

The **ScoreScreen** widget is the result screen that displays the quiz results to the user after they complete the quiz. It takes three parameters: `right`, `wrong`, and `total`, representing the number of correct answers, wrong answers, and the total score, respectively.

### Functionality:
- **Stateful Widget**:  
  The `ScoreScreen` is a stateful widget because it manages whether the scores should be displayed (`_showScores`). The screen waits for an animation to finish before displaying the results.
  
- **Animation**:  
  The screen shows an animation using the **Lottie** package. The animation path is chosen based on the total score. If the total score is less than 10, a "low score" animation is shown; otherwise, a "high score" animation is displayed. The `Lottie.asset()` function renders the animation from the assets folder.
  
- **Delayed Score Display**:  
  Upon initializing the state (`initState()`), a delay of 3 seconds is introduced using `Future.delayed`. After this delay, the `_showScores` state is set to true, which triggers the display of the score details.
  
- **Quiz Result Display**:  
  After the animation, the quiz results are displayed, including the right answer score, wrong answer score, and total score. The text styling is customized for a visually appealing dark theme with white text.
  
- **Retake Quiz Button**:  
  The user has the option to retake the quiz. Pressing the "Retake Quiz" button navigates to the **QuizScreen** via `Navigator.pushReplacement`. This method replaces the current screen with the quiz screen, allowing the user to start a new quiz.

### Plugins Used:
- **Lottie**: Used for rendering animated graphics in JSON format. The animations are placed in the `assets/animations/` folder.
