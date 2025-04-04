# 🧠 Lucid – A Mindful Study Companion

> 🏆 **Distinguished Winner – Swift Student Challenge 2025**

Lucid helps students tackle academic procrastination by promoting emotional awareness and reducing anxiety—through mindful interaction, persuasive design, and a focused user experience.

---

## ✨ What is Lucid?

**Lucid** is a study companion designed for students who struggle with procrastination. It leverages emotional management techniques and persuasive design to reduce anxiety and help users stay engaged with their academic tasks.

Inspired by real psychological research, Lucid turns the fight against procrastination into a guided, emotionally-aware journey.

---

## 💡 Why Lucid?

Lucid wasn’t just built to solve a problem — it came from something personal.

Like many students, I’ve struggled with procrastination. That familiar cycle of anxiety, avoidance, and last-minute rushes has followed me for years. Ironically, I even finished building Lucid during an all-nighter. But that only made the project feel more real — I was building something I genuinely needed.

To better understand *why* procrastination happens, I also dove into research on emotional regulation, anxiety, and motivation. I wanted to ground Lucid in something deeper than just productivity hacks — to design around the actual psychological causes. Some of the most relevant studies I referenced are included in the [`/Research`](./Research) folder.

Lucid was created to help break that cycle — to:

- Reduce anxiety tied to academic pressure  
- Help students understand and manage their emotions  
- Turn study time into a reflective, structured, and more rewarding experience

---

## 🧩 Core Features

> 🧪 Lucid is still a work in progress. Some features are partially implemented or being refined, and others are planned for future updates.

| Feature | Status |
|--------|--------|
| 🎯 **Study Projects** – Organize academic work into manageable steps. Only the next step is shown to avoid overwhelm. | ✅ Implemented |
| ⏳ **Gentle Deadlines** – Due dates remain hidden until they're close, reducing background stress. | ✅ Implemented |
| 🧘 **Emotional Awareness** – Users reflect on how they feel before each session to build mindfulness. | ✅ Implemented |
| ⏱️ **Timed Study Sessions** – Custom session timers to encourage focus and reward consistency. | ✅ Implemented |
| ☕ **Smart Breaks** – Encourages breaks in long sessions and uses notifications to return focus. | 🟡 WIP |
| 📊 **Mood Tracking** – Uses Natural Language framework to analyse emotional patterns over time. | ⚪ Not Yet |

✅ Implemented  🟡 Work In Progress  ⚪ Not Yet Available

---

## 🛠️ Built With

- `SwiftUI` – UI and interaction design  
- `UIKit` – Custom blur effects (ProgressiveBlur)  
- `SwiftData` – Data persistence 
- `UserNotifications` – Smart reminders and return-to-focus system  

---

## 📚 What I Wanted to Learn

Building Lucid was not just about solving a problem — it was also a chance to grow as a developer and designer.

Some of the goals I had in mind:

- **Design exploration**: I wanted to experiment with a visual style inspired by **VisionOS** and **glassmorphism**, aiming for a clean and calming interface that supports focus without distractions.
- **Custom components**: With the design approach I chose, I ended up building most UI components from scratch instead of relying on default elements, which helped me learn how to write clean, reusable code.
- **Smooth animations**: I paid extra attention to transitions and interactions, with the goal of keeping everything soft and fluid.
- **Mindful UX**: I wanted to understand how emotional awareness could be woven into the user experience, not just as a feature, but as a feeling that runs through the whole flow.

These choices shaped how the app looks and feels — and also taught me a lot along the way.

---

## 📱 Beyond the Playground

While originally developed for the Swift Student Challenge, Lucid is now being refined for a potential full release. You can explore other apps I’ve built on the [App Store](#) or follow the project for updates.

---

## 📄 Submission Essays

### 🟣 1. Tell us about your app in one sentence. What specific problem is it trying to solve? *(50 words)*  

Lucid helps students combat procrastination in academic tasks by promoting emotional awareness and easing anxiety through a mindful design.

---

### 🟣 2. Describe the user experience you were aiming for and why you chose the frameworks you used to achieve it. If you used AI tools, provide details about how and why they were used. *(500 words)*  

Studies show that procrastination often comes from a struggle to manage emotions. When faced with a task that feels overwhelming, it’s easy to avoid it —seeking relief from the anxiety or discomfort that comes with it. But this avoidance only deepens the procrastination cycle. Lucid was designed to break that cycle by creating an environment where students can acknowledge their feelings and focus only on what’s directly ahead, helping them avoid the anxiety that so often damages productivity.

When a user opens the app, they see a list of all their “Study Projects,” representing individual academic tasks like exams or assignments. To reduce stress, due dates are hidden until they’re imminent, rather than constantly looming in the background. The user breaks down each project into simple, manageable steps. To prevent feeling overwhelmed, the app only shows the next step, letting the user focus only on what’s immediately in front of them.

When the user is ready to begin, they start a “Study Session” and are prompted to reflect on how they’re feeling. This serves a dual purpose: it helps them track their mood while studying and, more importantly, it encourages them to understand why they feel a certain way about the task. This act of emotional awareness provides the brain with a more engaging experience than avoidance, turning the process of understanding emotions into a rewarding activity. By increasing self-awareness, the app helps users break the procrastination cycle. Additionally, the user selects the duration of the session, and a timer is displayed, offering a sense of accomplishment and reward when they stay focused and avoid procrastination.

But studying isn’t just about pushing through nonstop. The app knows that breaks are essential for maintaining productivity and mental clarity. So, for longer sessions, the app gently reminds users to take breaks and ensures they return to their work with a notification system, keeping the workflow balanced and stress-free.

I used the SwiftUI framework for the interface and the animations, while also using UIKit for a custom blur effect. For the data storage SwiftData was employed, guaranteeing data persistence. Finally UserNotifications was used to push local notifications to the user.

---

### 🟣 3. Beyond the Swift Student Challenge *(200 words)*

I've always been passionate about creating software that is both useful to me and beneficial to others. Throughout my coding journey, I've worked on projects that address real-world challenges, both in education and accessibility.

At the Apple Developer Academy, I collaborated with fellow students to design an app that helps visually impaired people navigate indoor spaces. To ensure its effectiveness, we engaged with specialized facilities, gathering insights to refine the user experience.

Beyond that, I’ve also developed numerous Swift Playgrounds for coding classes at my school and even had the opportunity to teach in some of them. During the lockdown, I used Swift to build projects that visualized mathematical concepts my class and I were studying—such as rendering Pascal’s triangle in the console. One of my ongoing projects, developed with classmates and my math teacher, is an app that solves systems of linear equations using different algorithms.

In the past, I also participated in a nationwide competition for Italian schools with an app that leverages AI to help students with special educational needs by generating summaries and diagrams, making studying more accessible.

---

### 🟣 4. Apps on the App Store *(200 words) (optional)*

So far, I’ve published two apps on the App Store: “Trippic!” and “FeelIt: Palette Manager.”

“Trippic!” was the first app I released. It’s a digital diary that allows users to document and preserve their travel experiences over time, capturing snapshots of landscapes, places, and meaningful encounters, along with the thoughts and feelings associated with them. I developed this app using SwiftUI and MapKit, fully localized in Italian and English, with VoiceOver support.

“FeelIt: Palette Manager” is the app I submitted for last year’s Swift Student Challenge. I was fortunate enough to win, which led to the publication of the project. This app is a palette creator that aims to encourage users to approach color selection with greater mindfulness, focusing on the emotions that color can convey.

---

### 🟣 5. Comments *(optional)*

I've always struggled with procrastination. It's a challenge that has followed me through my studies, turning even simple tasks into overwhelming obstacles. One of my recent exams was a wake-up call—I found myself caught in the cycle of delaying work, rushing at the last minute, and dealing with unnecessary stress.  

That experience made me reflect on why procrastination happens and how to break the cycle. I realized that the solution wasn’t just about time management but about understanding the emotions behind procrastination—why some tasks feel so daunting and why avoidance seems like the easier choice.  

This is what led me to create this app. I started by addressing a problem that affects me firsthand, but in the process, I discovered a broader approach to managing procrastination. The app isn’t just about getting things done—it’s about understanding why we avoid tasks in the first place and creating an environment where progress feels natural rather than forced.

---

## 📱 Beyond the Playground

While originally developed for the Swift Student Challenge, Lucid is now being refined for a potential full release. You can check updates on my [X/Twitter](https://twitter.com/alessiobrusco13) profile.

You can explore other apps I’ve published on the App Store: [FeelIt: Palette Manager](https://apps.apple.com/it/app/feelit-palette-manager/id6478206043?l=en-GB), that won the Swift Student Challenge in 2023; and [Trippic](https://apps.apple.com/it/app/trippic/id1635511527?l=en-GB), my first ever app.

---

## 🎈 Final Note

Lucid started as a way to deal with something I’ve always struggled with — and building it helped me understand that challenge a bit better.

If it can do the same for someone else, that’s more than enough.

Made with ❤️ by Alessio
