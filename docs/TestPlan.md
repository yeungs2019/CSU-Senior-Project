**Student Name:** Steven Yeung
**Advisor Name:** Dr. Sean Hayes
**Expected Date of Graduation:** December 2022

**Important Links:**

https://github.com/yeungs2019/CSU-Senior-Project

**Description:**

The four-part writing machine project is a plugin that recreates the rules of four-part harmony visually. It does this by implementing logic that takes tonal pitch classes, note pitch values, whole, and half steps to determine what rules have been broken in a user's four-part harmony.
**Statement of Purpose:**
**Purpose:**

The purpose of this project is to tie both computer science knowledge as well as music theory knowledge in one project. For many music theory students that have no prior knowledge on four-part harmony, this tool will a useful asset to them.

# **Problem Statement:**

Music students learning how to four-part write melodies easily and understanding how the rules work by using the project as a learning tool is the quickest and fastest way to learn the rules of four-part harmony. If all logic goes well in the project, students will not have an issue learning and understanding the rules of four-part running. Music theory is a difficult concept to understand, but with the creation of this project, the process of learning music theory will be more feasible.

Learning music theory and its rules are not at the speed as it should be. Many places for learning music theory are at a slow pace. It usually takes more than 2 months of time to have the theory rules completely secured. The problem is with the four-part writing rules. Many people have the difficulty in learning the four-part learning rules at a fast pace. Because many people have the trouble learning the rules quickly, it can slow down the instructor and cause him/her to slow down the pace, which is detrimental in covering all material effectively. Also, the handful of students that have the rules secured are forced to stay behind and review the same material along with those who are having difficulty with the rules.

The logic will be coded using a user programming language like JavaScript or Java or C++ and other extensions like QT. Logic will be applied to program according to the rules of four-part writing. The traditional way of teaching these rules is not as efficient because it requires another person to be present to correct the learner. With the creation of this program will allow the student to learn faster without another person(s) present. They may receive instant feedback on what is wrong with their melody, without telling them the answer, but will tell them exactly what is wrong. Struggling students will have a better time learning four-part writing with the machine because it can help them learn quicker and more efficiently.

# **Research and Background:**

Initially, I had extensive knowledge in four-part harmony when I took music theory. I wanted to incorporate music and computer science together to create something useful for people who are studying music theory. In general, the four-part harmony melodies are composed on paper. However, there is technology that is free to the public that allows a user to create their four-part harmony using a computer. The technology that I have found that can allow users to create their own four-part harmony digitally is Muse Score. Muse Score had already included a SATB blank for the user to do their melody. At first, Muse Score did not have a feature that allowed users to validate their own work. They would have to either research the rules themselves or consult another person to help validate their work. With a creation of a plugin, a user can insert rule checking code into the Muse Score plugin area to be able to validate their work.

The standard music theory rules that every person starts off learning are parallel fifths, parallel octaves, larger than a leap, and chordal sevenths. These four rules are the foundation of good four-part harmony. These rules were kept in the medieval to the modern era of music. Many musicians that are starting to learn four-part harmony are not able to detect these errors on their own because they are difficult to identify at first.

Muse Score was a familiar program to me at first because it was used to write and edit music. When it came to the computer science part of the program, it was new and I had to learn how it functioned. Fortunately, there was already an open-source code available that I could study and figure out how the application worked from that end.

After figuring out how the plugin worked, it was then on to learning the coding language required for this specific project. The new language that had to be learned was QML. It is a user interface markup language. In a way, it allows designers and developers to create their own thing. For this project, QML was the right language to use and it required logic to fulfill the requirements and needed the markup aspect so that the user was able to see what the logic did.

# **Project Language(s), Software, and Hardware:**

Project Language: QML

Project Software: Muse Score

Project Hardware: One Laptop

**Project Requirements:**

The minimal viable product is to be able to produce a fully functional four-part harmony validator. The product is to follow how a textbook and a professor would grade the most basic four-part harmony. This includes the fully functional parallel fifths, parallel eighths, large leap, and chordal sevenths.

Each rule is to have specific color and text markings in the staff to allow the user to identify the error that is being committed. The markings will be displayed in a linear fashion. Each note will be compared to the second note next to it. This is similar in a singly linked list fashion, where one list is compared to the one after it.

# **Project Implementation Description and Explanation:**

The four-part harmony error detection machine was developed using logic of whole and half steps. There are 12 half steps in an octave. Using this knowledge, implemented logic to trace how big each interval was in between notes.

For the user interface, the interface is already created with the app, Muse Score.

For the markup portion, the colors were implemented using HTML color codes. These colors are what the logic uses to display errors in the four-part writing. There also exists logic to check if notes are actually present in the score and that there is only one note per line (soprano, alto, tenor, bass). For the next series of tests, all will be read from left to right.

For the parallel fifths, the program will perform a linear scan in all parts. It will compare the soprano to alto, alto to tenor, tenor to bass, soprano to tenor, soprano to bass, etc. and identify the parallel fifth. There are seven half steps in a fifth, and twelve half steps in any scale. The program will use modulus to determine if two notes are a fifth apart in separate voices.

For the parallel octaves, it is similar to the parallel fifths, but this time it will calculate the half steps until the end (no remainder).

For the large leaps, the program will perform a linear scan in all parts. It will analyze each voice (soprano, alto, tenor, bass) separately. If there is an interval(s) that has more than eight half steps, it will mark it as large leap. In singing, jumping from one register to another can prove to be difficult.

For the chordal seventh, the program will perform a linear scan in all parts. It will analyze each voice (soprano, alto, tenor, bass) separately. This test will detect a chordal seventh, which is where the leading tone of a V7 chord does not resolve down. E.g., in the key of C major, the V7 is a G chord (G, B, D, F). The F (leading tone) must resolve down (resolves to E). If it resolves up, then this test case will highlight that error. In voicing, the resolution of the seventh is the standard because if it is not resolved, it will produce dissonance or the wanting of a note to finish its final note.

# **Test Plan:**

With each prototype of the four-part harmony error detection machine, there are 4 tests. Each test will use an example of a four-part melody. In the process of testing, I will use basic intervals to test. The program should be able to detect these intervals and display the error to the screen, nothing if all correct. To ensure that the error detection is running correctly, I will analyze the harmonies by hand and consult an expert if needed.

Test 1 will be parallel octaves: If there exists a parallel octave in the example, it will be highlighted. See Fig. 1. Test 2 will be parallel fifths. If there exists a parallel fifth in the example, it will be highlighted. See Fig. 2. Test 3 will be large leaps. If there exists a large leap (interval greater than a 6), it will be highlighted. See Fig. 3. Test 4 will be a chordal seventh. If there exists a chordal seventh in the example, it will be highlighted. See Fig. 4.

![](RackMultipart20221130-1-uqn25q_html_5a0b08454e3153ea.png) ![](RackMultipart20221130-1-uqn25q_html_895120331945afcd.png)

_Figure 1 Input and expected output of parallel octave._

![](RackMultipart20221130-1-uqn25q_html_99de3b9e8273d447.png) ![](RackMultipart20221130-1-uqn25q_html_c56a2bfa43e12b65.png)

_Figure 2 Input and expected output of a parallel fifth._

![](RackMultipart20221130-1-uqn25q_html_dd4bff4a442269b7.png) ![](RackMultipart20221130-1-uqn25q_html_7c2af69a3c972e58.png)

_Figure 3 Input and expected output of a large leap._

![](RackMultipart20221130-1-uqn25q_html_8ef71994f51d262c.png) ![](RackMultipart20221130-1-uqn25q_html_9016100076b40886.png)

_Figure 4 Input and expected output of a chordal seventh._

# **Test Results:**

Testing was done by using various of four part harmonies. Examples included professor examples, student examples, church hymns, etc.

Four-part harmony:

- No error: Passed
  - Test 1: Failed
  - Test 2: Failed
  - Test 3: Failed
  - Test 4: Failed

Expected Result is the same as actual result

In no error, the four tests shall fail because the machine failed to detect the errors, meaning that errors did not exist in the example.

Figure from Bach: "Loct Gott, ihr Christen, Allzugleich, BMV 376, mm. 1-2, transposed.

  -

![](RackMultipart20221130-1-uqn25q_html_983a6572e06b5b12.png)

Figure from a student.

![](RackMultipart20221130-1-uqn25q_html_fda1e176741133fe.png)

- Parallel octave: Passed
  - Test 1: Passed
  - Test 2: Failed
  - Test 3: Failed
  - Test 4: Failed

E ![](RackMultipart20221130-1-uqn25q_html_7351fe37b968a98f.png) ![](RackMultipart20221130-1-uqn25q_html_4dd1f9eff2eea67e.png) xpected result is actual result. No other errors except parallel octaves were included.

- Parallel fifth: Passed
  - Test 1: Failed
  - Test 2: Passed
  - Test 3: Failed
  - Test 4: Failed

Expected result is actual result. No other errors except parallel fifths were included

. ![](RackMultipart20221130-1-uqn25q_html_76412283ea84f61e.png)

![](RackMultipart20221130-1-uqn25q_html_b5ffbf6a39aff4a.png)

- Large Leap: Passed
  - Test 1: Failed
  - Test 2: Failed
  - Test 3: Passed
  - Test 4: Failed

Expected result is actual result. No other errors except large leaps were included. ![](RackMultipart20221130-1-uqn25q_html_aab0d4a5f8ec7e5c.png) ![](RackMultipart20221130-1-uqn25q_html_2d8f3d437a31fd47.png)

- Chordal seventh: Passed
  - Test 1: Failed
  - Test 2: Failed
  - Test 3: Failed
  - Test 4: Passed

Expected result is actual result. No other errors except chordal seventh were included.

![](RackMultipart20221130-1-uqn25q_html_8a80ad7795f59279.png) ![](RackMultipart20221130-1-uqn25q_html_6a9ae1e9288306bd.png)

_Figure 5 I V7 I chord progression._

# **Challenges Overcome:**

The main challenge that I faced was a platform to execute my idea. There were many software programs out there that allowed me to compose my own harmonies, but they did not have a place for me to implement code. I then looked into the documentation of Muse Score. They had a plugin feature within their app where anyone can implement whatever they want through their app.

After overcoming that challenge, I had in mind that I wanted to make something that only applied to the very basics of music theory. After taking four semesters of music theory, my knowledge on this topic was broad, but I wanted to make something that applied only to the beginners. After researching and consulting the music professor, he determined that the four basic fundamental rules for four-part harmony were the ones listed above. Keeping this in mind, I still had no knowledge of how the plugin feature worked.

Another challenge was learning how the plugin worked in Muse Score. I researched the documentation of Muse Score to find many plugins that other people have written. Other plugins include tuners, color melody notes, etc. After acquiring knowledge on how the plugins worked, I researched the languages that were popular associated with these plugins.

Learning a new programming language from scratch is always difficult. I had to learn the syntax and logic behind the new programming language. In this case, I had to learn QML, which is markup language (that's why I was able to display highlighted notes). It turns out that it was a lot less coding that I thought it would be because it provided the libraries I needed to be able to execute this project successfully.

# **Future enhancements:**

Future enhancements would include anything that is not in this version of this implementation. The parts that were not added included rules that were introduced in later periods of music. Rules that were not included were approaching the V chord with IV6, ii, ii7, and IV7, cadential 6/4, etc.

This would include more studies in music theory and it is a broad topic and can be molded in any way, shape, or form. The knowledge of computer science must also be extended as well as it would be more logic to implement for those other rules. An example would be checking tonic, subdominant, and dominant chords to make sure they are following correctly (I-IV-V). I-V-IV would be incorrect.
