
<h1>Todo CSV App</h1>
<p class="badge">Flutter • No third-party packages</p>
<p>A simple Todo mobile app (Flutter) that stores user todos in a CSV file on the device and supports importing additional todos from a JSON file selected from the device. This project follows a lightweight MVVM style: services (CSV/JSON), models, viewmodels (store), and UI widgets/screens.</p>


<h2>Features</h2>
<ul>
  <li>Material-based UI using Flutter core widgets.</li>
  <li>Add new todos and delete existing todos.</li>
  <li>Each todo contains: <code>id</code>, <code>title</code>, <code>description</code>, <code>created_at</code> (stored as <strong>int</strong>), <code>status</code> (one of <code>ready</code>, <code>pending</code>, <code>completed</code>).</li>
  <li>All changes persist to a CSV file on local device storage.</li>
  <li>Import additional todos from a JSON file on the device (Android file picker via platform channel — no packages used).</li>
  <li>Readable formatted time in UI: e.g. <code>9 Sep, 4:35 PM</code> while stored as an integer timestamp (ms since epoch).</li>
</ul>

<hr />

<h2>Repository structure</h2>
<pre>
lib/
 ├─ core/
 │   ├─ app_color.dart
 │   ├─ csv_read_write.dart  
 │   ├─ json_service.dart   
 │   └─ store_todo.dart      
  
 ├─ data/
 │   └─ model.dart           
 
 ├─ presentation/
 │   ├─ ui/
 │   │   ├─ widgets/       
 TodoListView
 │   │   ├─ add_todo.dart
 │   │   ├─ ready_todo.dart
 │   │   ├─ pending_todo.dart
 │   │   └─ complete_todo.dart
 │   └─ viewmodels/
 │       └─ add_todo_data.dart
 └─ android/                    // native platform channel implementation (MainActivity.kt + FileUtils.kt)
</pre>

<hr />

<h2>Model</h2>
<p>Each todo is represented as:</p>
<pre><code class="language-dart">class Todo {
  int id;
  String title;
  String description;
  int createdAt;
  String status;
}</code></pre>

<hr />

<h2>CSV format</h2>
<p>Each line in CSV represents one todo (simple comma separated columns). Example columns:</p>
<pre>
id,title,description,createdAt,status
1623456789012,Drutoloan Task,Without Packages,1694264160000, completed
</pre>

<hr />

<h2>JSON import example</h2>
<p>Place this JSON on your device (or pick it in the file picker). Example file <code>todos.json</code>:</p>
<pre><code class="language-json">[
  {
    "id": 24,
    "title": "Complete Flutter project",
    "description": "Finish Todo app and push to GitHub",
    "created_at": 1694256000000,
    "status": "ready"
  },
  {
    "id": 1454,
    "title": "Drutoloan Task",
    "description": "Without Packages",
    "created_at": 1694256000000,
    "status": "pending"
  },
  {
    "id": 34554,
    "title": "Want to learn new things ",
    "description": "Mobile Application Developer Junior (Flutter)",
    "created_at": 1694256000000,
    "status": "completed"
  }
]</code></pre>

<hr />

<h2>How it works (brief)</h2>
<ol>
  <li>UI (AddTodo screen) generates a timestamp using <code>DateTime.now().millisecondsSinceEpoch</code> and passes it to the Store when user taps Add.</li>
  <li>The Store (global single instance) holds an in-memory list and persists it to CSV after every change.</li>
  <li>List screens (Ready/Pending/Completed) read from Store and filter by <code>status</code>. Each todo presents <code>createdAtString</code> computed from the integer timestamp.</li>
  <li>JSON import uses a <code>MethodChannel</code> to call native Android code that opens the system file picker, reads the file to app cache, and returns the file path. Flutter reads and parses the JSON, converts to <code>Todo</code> objects, and calls <code>store.addTodos(List&lt;Todo&gt;)</code>, which saves to CSV.</li>
</ol>

<hr />

<h2>Android platform channel (no third-party)</h2>
<p>To keep the project package-free, the file picker is implemented using a platform channel.</p>
<ul>
  <li><strong>Flutter side</strong> uses <code>MethodChannel('app.channel.shared.files')</code> and invokes <code>pickJson</code>.</li>
  <li><strong>Android side</strong> (Kotlin) implements <code>configureFlutterEngine</code> and registers a <code>MethodChannel</code> handler that launches <code>Intent.ACTION_GET_CONTENT</code> with type <code>application/json</code>. The selected Uri is copied to app cache (FileUtils.getPath) and the path is returned to Flutter.</li>
</ul>

<hr />

<h2>Getting started (run locally)</h2>
<ol>
  <li>Ensure Flutter is installed: <code>flutter --version</code>.</li>
  <li>Clone the repository:
    <pre><code>git clone &lt;your-repo-url&gt; && cd repo-name</code></pre>
  </li>
  <li>Get packages (project uses only Flutter SDK; no third-party packages):
    <pre><code>flutter pub get</code></pre>
  </li>
  <li>Run on Android device:
    <pre><code>flutter run</code></pre>
    <em>Note:</em> After adding native Android code, do a full restart (not hot reload). If you change Kotlin/Java, run:
    <pre><code>flutter clean
flutter run</code></pre>
  </li>
</ol>

<hr />

<h2>Usage</h2>
<ul>
  <li>Open the app - go to <strong>Add</strong> page to create a todo. The app stores the created time as an integer timestamp internally.</li>
  <li>Switch to the filter tabs (Ready / Pending / Completed) to view todos by status. The UI shows human-friendly time formatted from the integer value (e.g. <code>9 Sep, 4:35 PM</code>).</li>
  <li>Use the <strong>Import JSON</strong> button to open the Android file picker and select a JSON file formatted like the example above. Imported todos are appended to the in-memory list and persisted to CSV.</li>
  <li>Delete a todo using the delete icon in the list — the action removes it from memory and updates the CSV.</li>
</ul>

<hr />


<h2>Design & Architecture notes</h2>
<ul>
  <li>Simple MVVM-ish layout: UI (Widgets/Screens) → ViewModels (store/add handlers) → Services (CSV/JSON) → Model (Todo).</li>
  <li>No third-party packages were used by requirement — native Android code is used for file picking via platform channel.</li>
  <li>Times are stored as integer milliseconds since epoch for portability and sorting; UI converts to formatted human strings.</li>
</ul>

<hr />



