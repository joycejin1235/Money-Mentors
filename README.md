# Money Mentors

A student-friendly classroom dashboard with interactive simulations. The current games introduce AI ethics. It runs as a static website using plain HTML, CSS, and JavaScript, so there are no packages to install or build steps.

## What's inside

- **Welcome dashboard:** An introduction to Money Mentors' free week-long summer camps, online classes, and in-person sessions.
- **Class folders:** Simulations are grouped by class and week. The current folder, **AI in the Business World — Week 3**, contains the three classroom games.
- **The Hiring Challenge:** Compare a fair, human-led review of fictional candidates with an intentionally flawed AI screening tool.
- **Real, Fake, or Uncertain?:** Inspect eight fictional business messages, reviews, and advertisements for warning signs, with original illustrations.
- **AI: Ethical or Not?:** Explore fictional situations and think through the choices and tradeoffs.
- **Classroom-friendly play:** Games include feedback and replay; incorrect answers in three-choice rounds can be retried.
- **Presentation mode:** Expand the simulations to fill the screen for classroom display, then return to the dashboard layout.
- **Private by design:** Activities run in the browser without accounts, network services, or stored student data.

## Run locally on Windows

From this folder, start the included PowerShell web server:

```powershell
.\server.ps1
```

Open [http://localhost:8000](http://localhost:8000) in a browser. Stop the server with `Ctrl+C`. If script execution is restricted, start it with `powershell -ExecutionPolicy Bypass -File .\server.ps1`.

To publish the site, host `index.html` on any static web host or copy it into the document root of a web server.
