# yin-ying-hub = run script html=("https://raw.githubusercontent.com/hacker0030mp/yin-ying-hub/refs/heads/main/MAC-MAX-HUB-X-Redesigned.html")
<!DOCTYPE html>
<html lang="th">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MAC-MAX HUB-X | Script Workspace</title>
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- FontAwesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts: Prompt & Fira Code -->
    <link href="https://fonts.googleapis.com/css2?family=Prompt:wght@300;400;500;600;700&family=Fira+Code:wght@400;500;600&display=swap" rel="stylesheet">

    <script>
        tailwind.config = {
            darkMode: 'class',
            theme: {
                extend: {
                    colors: {
                        hub: {
                            bg: '#0a0c14',
                            card: '#121624',
                            border: '#1f293d',
                            cyan: '#00f0ff',
                            pink: '#ff0055',
                            purple: '#7000ff',
                            green: '#00ff88',
                            yellow: '#ffcc00'
                        }
                    },
                    fontFamily: {
                        sans: ['Prompt', 'sans-serif'],
                        code: ['Fira Code', 'monospace']
                    }
                }
            }
        }
    </script>

    <style>
        body {
            background-color: #0a0c14;
            color: #f1f5f9;
            background-image: 
                radial-gradient(circle at 10% 20%, rgba(112, 0, 255, 0.12) 0%, transparent 40%),
                radial-gradient(circle at 90% 80%, rgba(0, 240, 255, 0.12) 0%, transparent 40%);
            background-attachment: fixed;
        }

        /* Custom Scrollbar */
        ::-webkit-scrollbar {
            width: 6px;
            height: 6px;
        }
        ::-webkit-scrollbar-track {
            background: #0a0c14;
        }
        ::-webkit-scrollbar-thumb {
            background: #1f293d;
            border-radius: 3px;
        }
        ::-webkit-scrollbar-thumb:hover {
            background: #00f0ff;
        }

        .glow-cyan {
            box-shadow: 0 0 15px rgba(0, 240, 255, 0.3);
        }
        .glow-pink {
            box-shadow: 0 0 15px rgba(255, 0, 85, 0.3);
        }
        .glow-green {
            box-shadow: 0 0 15px rgba(0, 255, 136, 0.3);
        }
    </style>

<style id="macmax-new-design">
:root{--mx-bg:#090d14;--mx-panel:#111a27;--mx-panel2:#162233;--mx-line:#26384b;--mx-text:#eaf2fb;--mx-muted:#8fa2b8;--mx-accent:#50e3c2;--mx-blue:#66a8ff}
*{box-sizing:border-box}
html{scroll-behavior:smooth}
body{background:var(--mx-bg)!important;background-image:radial-gradient(ellipse at 70% -15%,rgba(80,227,194,.12),transparent 38%),linear-gradient(145deg,#090d14,#0d1420 55%,#0a101a)!important;color:var(--mx-text)!important;display:block!important;min-height:100vh;padding-top:70px}
header{height:70px;position:fixed!important;inset:0 0 auto 0;z-index:45;background:rgba(9,13,20,.92)!important;border-bottom:1px solid var(--mx-line)!important;backdrop-filter:blur(18px)}
header>div{max-width:none!important;padding:0 26px!important;height:70px!important}
header #open-drawer-btn{display:none}
header .w-9{border-radius:12px!important;background:linear-gradient(135deg,#50e3c2,#4e8cff)!important;box-shadow:0 8px 25px #50e3c226}
header span.font-bold{letter-spacing:.04em}
#drawer-overlay{display:none!important}
#drawer{position:fixed!important;top:70px!important;left:0!important;bottom:0!important;height:calc(100dvh - 70px)!important;width:258px!important;transform:translateX(0)!important;z-index:40!important;padding:20px 14px!important;background:#0e1723!important;border-right:1px solid var(--mx-line)!important;border-radius:0!important;box-shadow:none!important}
#drawer>div:first-child{overflow-y:auto}
#drawer>div:first-child>.flex.items-center.justify-between{padding:0 8px 16px!important}
#drawer>div:first-child>.flex.items-center.justify-between h3{font-size:13px!important;letter-spacing:.12em;text-transform:uppercase;color:var(--mx-muted)!important}
#drawer>div:first-child>.flex.items-center.justify-between button{display:none}
#drawer .my-5{margin:14px 0 20px!important;background:var(--mx-panel)!important;border:1px solid var(--mx-line)!important;border-radius:14px!important;padding:13px!important}
#drawer nav{display:flex;flex-direction:column;gap:5px!important}
#drawer nav>div{padding:18px 10px 5px!important;font-size:9px!important;letter-spacing:.18em!important}
#drawer nav button{min-height:43px;border:1px solid transparent!important;border-radius:10px!important;padding:10px 12px!important;color:#91a4ba!important;font-size:12px!important;transition:.18s ease}
#drawer nav button:hover{background:#182638!important;color:#eaf2fb!important;border-color:#2a4055!important}
#drawer nav button.text-hub-cyan{background:rgba(80,227,194,.1)!important;color:var(--mx-accent)!important;border-color:rgba(80,227,194,.24)!important}
#drawer nav button i{width:18px;text-align:center}
#drawer>div:last-child{font-size:9px!important;color:#61748a!important;border-color:var(--mx-line)!important}
main{max-width:none!important;width:auto!important;margin:0 0 0 258px!important;padding:28px clamp(16px,3vw,44px) 55px!important;min-height:calc(100vh - 70px)}
main>section{max-width:1180px;margin:0 auto}
main h1{font-size:clamp(24px,3vw,36px)!important;text-align:left!important;letter-spacing:-.035em!important}
main section>div:first-child:has(>h1){text-align:left!important;margin-bottom:22px}
main section>div:first-child:has(>h1) p{max-width:680px;line-height:1.7}
.bg-hub-card{background:linear-gradient(145deg,rgba(20,32,47,.98),rgba(14,23,35,.98))!important;border:1px solid var(--mx-line)!important;border-radius:16px!important;box-shadow:0 14px 45px rgba(0,0,0,.16)!important}
.bg-hub-bg{background:#0b131e!important}
.border-hub-border{border-color:var(--mx-line)!important}
.rounded-2xl{border-radius:17px!important}
.rounded-xl{border-radius:11px!important}
input,select,textarea{background:#0a121d!important;border-color:#2a3b50!important;color:#eaf2fb!important;border-radius:10px!important}
input:focus,select:focus,textarea:focus{outline:none!important;border-color:var(--mx-accent)!important;box-shadow:0 0 0 3px rgba(80,227,194,.09)!important}
button{transition:transform .16s ease,background .16s ease,border-color .16s ease}
button:active{transform:translateY(1px)}
#drop-zone{background:linear-gradient(135deg,rgba(80,227,194,.055),rgba(102,168,255,.045))!important;border:1px dashed #3b6470!important;border-radius:15px!important;padding:30px!important}
#drop-zone:hover{background:rgba(80,227,194,.09)!important;border-color:var(--mx-accent)!important}
#tab-studio textarea{min-height:310px;line-height:1.65}
#studio-preview,#internal-browser-frame{border:1px solid var(--mx-line)!important;border-radius:12px!important;background:white}
#runtime-mode-panel{background:#0c1520!important;border:1px solid #2a4054!important}
#runtime-mode-panel label{background:#111d2b!important;border-color:#2a4054!important;border-radius:11px!important}
#runtime-mode-panel label:has(input:checked){border-color:var(--mx-accent)!important;background:rgba(80,227,194,.07)!important}
#runtime-info{padding:10px 12px;background:#101d2a;border:1px solid #24384a;border-radius:9px;line-height:1.6}
#viewer-modal>div{border:1px solid var(--mx-line)!important;border-radius:18px!important}
#toast{border-radius:12px!important}
.text-hub-cyan{color:var(--mx-accent)!important}
.bg-hub-cyan\/10{background:rgba(80,227,194,.1)!important}
.border-hub-cyan\/30{border-color:rgba(80,227,194,.3)!important}
.text-gray-400{color:#91a4ba!important}
.text-gray-500{color:#71859b!important}
.text-hub-green{color:#65e6b8!important}
.bg-hub-green{background:#65e6b8!important}
@media(max-width:800px){
 body{padding-top:62px}
 header,header>div{height:62px!important}
 header>div{padding:0 14px!important}
 header #open-drawer-btn{display:block!important;padding:8px!important}
 #drawer{top:62px!important;height:calc(100dvh - 62px)!important;width:min(86vw,290px)!important;transform:translateX(-105%)!important;transition:transform .25s ease!important}
 #drawer.translate-x-0{transform:translateX(0)!important}
 #drawer.-translate-x-full{transform:translateX(-105%)!important}
 #drawer-overlay{display:block!important}
 main{margin:0!important;padding:20px 14px 40px!important}
 main>section{width:100%}
 main h1{text-align:left!important}
}
@media(min-width:801px){#drawer-overlay{display:none!important}}
</style>

</head>
<body class="font-sans min-h-screen flex flex-col justify-between overflow-x-hidden">

    <!-- Toast Notification -->
    <div id="toast" class="fixed bottom-5 right-5 z-50 transform translate-y-20 opacity-0 transition-all duration-300 pointer-events-none bg-hub-card border border-hub-green text-white px-5 py-3.5 rounded-xl shadow-lg flex items-center gap-3">
        <i id="toast-icon" class="fa-solid fa-circle-check text-hub-green text-xl"></i>
        <span id="toast-msg" class="text-sm font-medium">ทำรายการสำเร็จแล้ว!</span>
    </div>

    <!-- Header Bar -->
    <header class="border-b border-hub-border bg-hub-bg/80 backdrop-blur-md sticky top-0 z-40">
        <div class="max-w-7xl mx-auto px-4 h-16 flex items-center justify-between">
            <div class="flex items-center gap-3">
                <button id="open-drawer-btn" onclick="toggleDrawer(true)" class="p-2.5 text-hub-cyan hover:bg-hub-card rounded-lg transition-all text-xl">
                    <i class="fa-solid fa-bars"></i>
                </button>
                <div class="flex items-center gap-2 cursor-pointer" onclick="switchTab('create')">
                    <div class="w-9 h-9 rounded-lg bg-gradient-to-br from-hub-cyan to-hub-purple flex items-center justify-center text-black font-black text-lg">
                        <i class="fa-solid fa-bolt"></i>
                    </div>
                    <span class="font-bold text-xl tracking-wide text-white">MAC-MAX <span class="text-hub-cyan">HUB-X</span></span>
                </div>
            </div>

            <div class="flex items-center gap-3">
                <span class="hidden sm:flex items-center gap-1.5 text-xs bg-hub-purple/20 text-hub-cyan border border-hub-purple/40 px-3 py-1 rounded-full font-code">
                    <span class="w-2 h-2 rounded-full bg-hub-green animate-pulse"></span> SYSTEM ONLINE
                </span>
            </div>
        </div>
    </header>

    <!-- Side Drawer Menu (ขีด 3 ขีด) -->
    <div id="drawer-overlay" onclick="toggleDrawer(false)" class="fixed inset-0 bg-black/70 backdrop-blur-sm z-50 hidden transition-opacity"></div>
    <aside id="drawer" class="fixed top-0 left-0 h-full w-80 bg-hub-card border-r border-hub-border z-50 transform -translate-x-full transition-transform duration-300 ease-in-out flex flex-col justify-between p-5">
        <div>
            <!-- Drawer Header -->
            <div class="flex items-center justify-between border-b border-hub-border pb-4">
                <div class="flex items-center gap-2">
                    <i class="fa-solid fa-bars-staggered text-hub-cyan"></i>
                    <h3 class="font-bold text-white text-lg">เมนูหลัก (Menu)</h3>
                </div>
                <button onclick="toggleDrawer(false)" class="text-gray-400 hover:text-white text-xl">
                    <i class="fa-solid fa-xmark"></i>
                </button>
            </div>

            <!-- User Info -->
            <div class="my-5 p-3 rounded-xl bg-hub-bg border border-hub-border flex items-center gap-3">
                <div class="w-10 h-10 rounded-full bg-hub-purple/30 border border-hub-purple flex items-center justify-center text-hub-cyan text-xl">
                    <i class="fa-solid fa-user-shield"></i>
                </div>
                <div>
                    <h4 class="font-bold text-sm text-white">MAC-MAX USER</h4>
                    <span class="text-xs text-hub-green flex items-center gap-1">
                        <i class="fa-solid fa-circle text-[8px]"></i> บัญชีพร้อมใช้งาน
                    </span>
                </div>
            </div>

            <!-- Drawer Navigation -->
            <nav class="space-y-1.5">
                <button onclick="switchTab('create')" id="menu-btn-create" class="w-full flex items-center gap-3 px-4 py-3 rounded-xl text-sm font-medium transition-all text-hub-cyan bg-hub-cyan/10 border border-hub-cyan/30">
                    <i class="fa-solid fa-plus-circle text-lg"></i>
                    <span>สร้างลิงก์ / อัปโหลด</span>
                </button>

                <button onclick="switchTab('my-hub')" id="menu-btn-my-hub" class="w-full flex items-center justify-between px-4 py-3 rounded-xl text-sm font-medium text-gray-400 hover:text-white hover:bg-hub-bg transition-all">
                    <div class="flex items-center gap-3">
                        <i class="fa-solid fa-folder-open text-lg"></i>
                        <span>ของฉัน (My Hub)</span>
                    </div>
                    <span id="drawer-my-count" class="bg-hub-pink text-white text-xs px-2 py-0.5 rounded-full font-code">0</span>
                </button>

                <div class="pt-3 pb-1 text-[11px] font-bold text-gray-500 uppercase tracking-wider px-4">หมวดหมู่อื่นๆ</div>

                <button onclick="switchTab('trending')" id="menu-btn-trending" class="w-full flex items-center gap-3 px-4 py-2.5 rounded-xl text-sm font-medium text-gray-400 hover:text-white hover:bg-hub-bg transition-all">
                    <i class="fa-solid fa-fire text-hub-yellow"></i>
                    <span>คลังสคริปต์ยอดฮิต</span>
                </button>

                <button onclick="switchTab('obfuscator')" id="menu-btn-obfuscator" class="w-full flex items-center gap-3 px-4 py-2.5 rounded-xl text-sm font-medium text-gray-400 hover:text-white hover:bg-hub-bg transition-all">
                    <i class="fa-solid fa-lock-keyhole text-hub-pink"></i>
                    <span>เครื่องมือล็อกโค้ด (Obfuscator)</span>
                </button>

                <button onclick="switchTab('video-tools')" id="menu-btn-video-tools" class="w-full flex items-center gap-3 px-4 py-2.5 rounded-xl text-sm font-medium text-gray-400 hover:text-white hover:bg-hub-bg transition-all">
                    <i class="fa-solid fa-film text-hub-purple"></i>
                    <span>เครื่องมือวิดีโอ</span>
                </button>

                <button onclick="switchTab('studio')" id="menu-btn-studio" class="w-full flex items-center gap-3 px-4 py-2.5 rounded-xl text-sm font-medium text-gray-400 hover:text-white hover:bg-hub-bg transition-all">
                    <i class="fa-solid fa-play text-hub-green"></i><span>App Play Script / Editor</span>
                </button>
                <button onclick="switchTab('browser')" id="menu-btn-browser" class="w-full flex items-center gap-3 px-4 py-2.5 rounded-xl text-sm font-medium text-gray-400 hover:text-white hover:bg-hub-bg transition-all">
                    <i class="fa-solid fa-globe text-hub-cyan"></i><span>Internal Browser</span>
                </button>
                <button onclick="switchTab('versions')" id="menu-btn-versions" class="w-full flex items-center gap-3 px-4 py-2.5 rounded-xl text-sm font-medium text-gray-400 hover:text-white hover:bg-hub-bg transition-all">
                    <i class="fa-solid fa-code-branch text-hub-purple"></i><span>Script Versions</span>
                </button>
                <button onclick="switchTab('settings')" id="menu-btn-settings" class="w-full flex items-center gap-3 px-4 py-2.5 rounded-xl text-sm font-medium text-gray-400 hover:text-white hover:bg-hub-bg transition-all">
                    <i class="fa-solid fa-gear text-gray-400"></i><span>ตั้งค่าระบบ</span>
                </button>
            </nav>
        </div>

        <div class="border-t border-hub-border pt-4 text-center text-xs text-gray-500 font-code">
            MAC-MAX HUB-X v2.5 PRO
        </div>
    </aside>

    <!-- Main Container -->
    <main class="max-w-5xl mx-auto px-4 py-8 flex-grow w-full">

        <!-- TAB 1: CREATE & UPLOAD -->
        <section id="tab-create" class="space-y-6">
            <div class="text-center space-y-2">
                <h1 class="text-2xl sm:text-4xl font-extrabold text-white tracking-tight">
                    MAC-MAX <span class="text-transparent bg-clip-text bg-gradient-to-r from-hub-cyan via-hub-purple to-hub-pink">HUB-X SYSTEM</span>
                </h1>
                <p class="text-gray-400 text-xs sm:text-sm">เลือกรูปแบบหมวดหมู่และสร้างลิงก์สำหรับวิดีโอ หรือสคริปต์แบบล็อกรอนับถอยหลัง 30 วินาที</p>
            </div>

            <!-- Form Card -->
            <div class="bg-hub-card border border-hub-border rounded-2xl p-6 shadow-2xl space-y-6">

                <!-- Drag & Drop Zone -->
                <div id="drop-zone" onclick="document.getElementById('file-input').click()" class="border-2 border-dashed border-hub-border hover:border-hub-cyan bg-hub-bg/50 rounded-xl p-8 text-center cursor-pointer transition-all">
                    <i class="fa-solid fa-cloud-arrow-up text-4xl text-hub-cyan mb-3"></i>
                    <p class="text-sm font-semibold text-white">ลากไฟล์มาวางที่นี่ หรือ <span class="text-hub-cyan underline">คลิกเพื่อเลือกไฟล์</span></p>
                    <p class="text-xs text-gray-500 mt-1">รองรับ: .mp4, .mov, .html, .js, .css, .lua, .luau, .py, .txt</p>
                    <input type="file" id="file-input" class="hidden" accept=".mp4,.mov,.avi,.mkv,.webm,.html,.htm,.js,.css,.lua,.luau,.py,.txt,.json" onchange="handleFileSelect(this.files[0])">
                </div>

                <form id="create-form" onsubmit="handleFormSubmit(event)" class="space-y-5">

                    <!-- Category Selector -->
                    <div>
                        <label class="block text-xs font-semibold text-hub-cyan uppercase tracking-wider mb-2">
                            <i class="fa-solid fa-list-check mr-1"></i> เลือกหมวดหมู่การใช้งาน (Category)
                        </label>
                        <select id="category-select" onchange="handleCategoryChange()" class="w-full bg-hub-bg border border-hub-border focus:border-hub-cyan focus:ring-1 focus:ring-hub-cyan rounded-xl px-4 py-3 text-white outline-none transition-all text-sm">
                            <option value="1">หมวดหมู่ 1: วิดีโอ (Videos: mp4, mov, ฯลฯ)</option>
                            <option value="2">หมวดหมู่ 2: อัปโหลดไฟล์สคริปต์ (File Script: html, js, css, lua, luau, py)</option>
                            <option value="3">หมวดหมู่ 3: สคริปต์แบบข้อความ/พาสสปีด (Text Paste Script)</option>
                            <option value="4" selected>หมวดหมู่ 4: ล็อกสคริปต์ (Lock Script - Obfuscate + รอ 30 วินาที)</option>
                        </select>
                    </div>

                    <!-- Dynamic Fields Container -->
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div id="field-video-name">
                            <label class="block text-xs font-semibold text-gray-300 mb-2">ชื่อวิดีโอ (Video Title/ID)</label>
                            <input type="text" id="input-video-name" required value="chimaeras" placeholder="เช่น chimaeras" 
                                class="w-full bg-hub-bg border border-hub-border focus:border-hub-cyan rounded-xl px-4 py-2.5 text-white text-sm outline-none">
                        </div>

                        <div id="field-video-ext">
                            <label class="block text-xs font-semibold text-gray-300 mb-2">นามสกุลไฟล์วิดีโอ</label>
                            <select id="input-video-ext" class="w-full bg-hub-bg border border-hub-border focus:border-hub-cyan roun
