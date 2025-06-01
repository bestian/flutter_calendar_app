'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"favicon-16x16.png": "88c5f2ac61a8635c7cdcf47b7b64c2c0",
"flutter_bootstrap.js": "f315396a4e22640513154ad4783a9ac7",
"version.json": "97f0a1dbbf948731e7f8edda1b5f1a64",
"favicon.ico": "44f9a8f97c5609eda88ad4bea2fa2c7d",
"index.html": "9800717a353e5c6cfc7a076772ab1291",
"/": "9800717a353e5c6cfc7a076772ab1291",
"main.dart.js": "d5266b9656c88378a8ae05bc99c0798a",
"flutter.js": "383e55f7f3cce5be08fcf1f3881f585c",
"favicon-96x96.png": "1e52a946a1f5aaf3f497114074df421e",
"icons/apple-icon.png": "2bc173323bfa50e248d232c2c8de845a",
"icons/apple-icon-144x144.png": "1a353a27e1241f1962f53824be2c63ba",
"icons/android-icon-192x192.png": "a081e4770338faf6532fef17c233322c",
"icons/apple-icon-precomposed.png": "8742213417cebbbb345d23d023abdea3",
"icons/apple-icon-114x114.png": "52fb5aa9db72a53286801f6d65945fd0",
"icons/ms-icon-310x310.png": "3d7ce89ec254c6b704f122f97e94f66d",
"icons/ms-icon-144x144.png": "ef9e9fe31674d698c3ae359b9dae7413",
"icons/apple-icon-57x57.png": "794fd2dd82493904c8d9086e0e4073db",
"icons/apple-icon-152x152.png": "a4269d69b3ea8635b7bb8de47ab25caf",
"icons/ms-icon-150x150.png": "e0b3217a5df76722de02f8c838b0dea1",
"icons/android-icon-72x72.png": "f751789a0f520ce580cb7be581d00eea",
"icons/android-icon-96x96.png": "826cbfeedb779e9e95e730852beb09f0",
"icons/android-icon-36x36.png": "78c7226705e5229f2d76d725070415f4",
"icons/apple-icon-180x180.png": "86e13012027720e256fe12dbcac180ba",
"icons/android-icon-48x48.png": "1e384621d2b26db047debc17ecb9a410",
"icons/apple-icon-76x76.png": "8589cc429327a3295fd1203246365445",
"icons/apple-icon-60x60.png": "809824f1d4aaca5bd3625cafc689904e",
"icons/android-icon-144x144.png": "1a353a27e1241f1962f53824be2c63ba",
"icons/apple-icon-72x72.png": "f751789a0f520ce580cb7be581d00eea",
"icons/apple-icon-120x120.png": "939e859204a4ec5a860ee81872ed75e0",
"icons/ms-icon-70x70.png": "18fd993435c78c961f6e65061016c461",
"manifest.json": "5a1e089b0e40a48263993c4df3298f69",
".git/config": "d25064b42cc7f6a99743c4c96d060553",
".git/objects/0c/6cb6e633bc292df45b42eb239e847884fae2bc": "45d2f53da08c25e1b1b6ec4a3cd76e9e",
".git/objects/9e/6115ad2b98607c9fd8711420bf59a66b0910e0": "41e8751facff1bdcdfd779d2bfe6075f",
".git/objects/9e/26dfeeb6e641a33dae4961196235bdb965b21b": "304148c109fef2979ed83fbc7cd0b006",
".git/objects/6a/9c54a6c9cb525bed4c581a51f2551989af3087": "5dd967d840c62973ba431b26a4ccea5a",
".git/objects/3c/5e3cdd62ea7b1c7b5460a5177f6b30eb2916c8": "4e37d9e674cdaf22287b3165e39bbf23",
".git/objects/51/0434fba2a02fa19f441b215f151b7246dd17f6": "87fac90c275cd01bb5c4615f9f63d894",
".git/objects/58/04a5e0acc1d63668320b4117846a7b3c1abbf1": "c9452ee31e4bac3068fd8ed4e19a7595",
".git/objects/58/b007afeab6938f7283db26299ce2de9475d842": "6c6cbea527763bb3cdff2cecfee91721",
".git/objects/58/356635d1dc89f2ed71c73cf27d5eaf97d956cd": "f61f92e39b9805320d2895056208c1b7",
".git/objects/0b/697d3a02acb2abdc839228fd9b02aff18f74de": "6817b2b575a1e94be919e083dfdcfca6",
".git/objects/93/d7f4dfa48b993daad755500866d40136b48c70": "7b77aee58237a2a446a39829f7b1179f",
".git/objects/94/f7d06e926d627b554eb130e3c3522a941d670a": "77a772baf4c39f0a3a9e45f3e4b285bb",
".git/objects/b3/ebbd38f666d4ffa1a394c5de15582f9d7ca6c0": "23010709b2d5951ca2b3be3dd49f09df",
".git/objects/b4/a3ecb9428e2a4b8aff40c099e1c27d64a928f0": "6e4bc29289eb6be950713f1b329eaf0d",
".git/objects/d1/098e7588881061719e47766c43f49be0c3e38e": "f17e6af17b09b0874aa518914cfe9d8c",
".git/objects/d6/fcbabbdc1f9d40530cfe032328a2ed119d5fdd": "b79b79763191f32167f3d97dac66784d",
".git/objects/d6/9c56691fbdb0b7efa65097c7cc1edac12a6d3e": "868ce37a3a78b0606713733248a2f579",
".git/objects/eb/9b4d76e525556d5d89141648c724331630325d": "37c0954235cbe27c4d93e74fe9a578ef",
".git/objects/c9/bf8af1b92c723b589cc9afadff1013fa0a0213": "632f11e7fee6909d99ecfd9eeab30973",
".git/objects/c9/c0d666a6eef8a37ce87ff8efe1b7da68e365c3": "cc854d8f7efe24002881dab9a7c9f5b3",
".git/objects/f2/04823a42f2d890f945f70d88b8e2d921c6ae26": "6b47f314ffc35cf6a1ced3208ecc857d",
".git/objects/f2/2dfe0e73eeb649ec824cebab7680011866d83d": "197ac5582200574b7bfb6fe62dcf7ab8",
".git/objects/20/cb2f80169bf29d673844d2bb6a73bc04f3bfb8": "b807949265987310dc442dc3f9f492a2",
".git/objects/20/1afe538261bd7f9a38bed0524669398070d046": "82a4d6c731c1d8cdc48bce3ab3c11172",
".git/objects/18/eb401097242a0ec205d5f8abd29a4c5e09c5a3": "4e08af90d04a082aab5eee741258a1dc",
".git/objects/1f/6656b24b8a8ef57ca6253d719154b1f6ece387": "7966efa06e942de8f81b32ac8d813cda",
".git/objects/17/e89671d9ba9bcbe77d11b267f3b31171634e51": "47ea52b34a26d74562e13b7fd5604168",
".git/objects/7b/cfbfc80015cafb425d22cc18265ddb9bb855d0": "fb2666623480b65a5d6bc079ba4d93c8",
".git/objects/8f/368292a70675725b4d450fb31a7af7e7a2465c": "f772b016eabfd2336c517d3cfb18602d",
".git/objects/8a/aa46ac1ae21512746f852a42ba87e4165dfdd1": "1d8820d345e38b30de033aa4b5a23e7b",
".git/objects/7e/ec6e1bae7107ee6ef66871ba1924e88c44f2e3": "4d8c0ce5956d442777290b89d20c9972",
".git/objects/4c/ac2c103477192fd389f33bd316dea77bcdb71f": "f06d21bcc9b9f3b53db1bd777147f5d9",
".git/objects/86/d111f09a93cccfa0011858c519a823e7dafef7": "9a15839a59b5f501fbf7b9824c4b6f84",
".git/objects/88/cfd48dff1169879ba46840804b412fe02fefd6": "e42aaae6a4cbfbc9f6326f1fa9e3380c",
".git/objects/6e/820d18372f25d3cbb6d132acbf263534458b26": "5d3df8ac6da61a62d26b87f268bb9080",
".git/objects/09/4bb6ae24f0cd847d40cb4cc4a2434f2ec9b83b": "b9e6d850322c11db635bcf0a45b762ff",
".git/objects/91/515c7ca08008977d2c6145d92ae50a31b2c041": "b2657c9d0d45d4f1e6d170299ab09a3b",
".git/objects/91/d8e9e0a39a9ffa01e619d9df7dabf78c108d4e": "d57d498468bdbc3c52d49594a928c31d",
".git/objects/62/02c1f58289b9ff638cc422d373e73e6a6e01ca": "c30ca7ce6291adeca24e6889ba7eade2",
".git/objects/3a/bf18c41c58c933308c244a875bf383856e103e": "30790d31a35e3622fd7b3849c9bf1894",
".git/objects/30/4edca7a5523b89ce96cd7bf05a56971974ac71": "179667f1a2b082b6194396bd2a010f58",
".git/objects/99/33b8257ce896cdfc6908e6f0f9c97aaaeb2e50": "e06d0c20c4a53a7945a03d1e1051db55",
".git/objects/63/11988f09c7daf2c0ae2ba282d3db7122421254": "52275729a48a4b8e65cdd375019e9c00",
".git/objects/bf/e99b6e8e9454241d61b89cabfd4ca726efe0dd": "38efd627db70468ee66bede025504c25",
".git/objects/d4/3532a2348cc9c26053ddb5802f0e5d4b8abc05": "3dad9b209346b1723bb2cc68e7e42a44",
".git/objects/a7/855361eca5b74c348200177b8bd14258f85051": "353f0fdf33c508651891de5a8d3f7549",
".git/objects/b1/bdf943db7307709eb19fd64184b6433469b785": "6dc0f602f3fd4ee638e4cbb24bc74d09",
".git/objects/d5/aa7684e841ff3ec24bd3589814007ec81cadd3": "5605b70a920b74525381af7ef317547f",
".git/objects/b7/49bfef07473333cf1dd31e9eed89862a5d52aa": "36b4020dca303986cad10924774fb5dc",
".git/objects/b7/d2731bcf406214fc2ac578617919e16ecea0e2": "5f7beae64d0e829eb9c770ae6c3d0b33",
".git/objects/b0/30a40035bf94eb7626c8bded35b40e8102a081": "54ac361230c0b5411f76365650b9ad8a",
".git/objects/b9/2a0d854da9a8f73216c4a0ef07a0f0a44e4373": "f62d1eb7f51165e2a6d2ef1921f976f3",
".git/objects/ef/662e50425b8d447de583ed154e699faa55a0c4": "bca1c77fc57bcd3c5d6b3800f9f20749",
".git/objects/c3/8966946f392fb441dc5b7e04301cc78faab442": "356a2d5745c3fda3217292a0d7b85fc6",
".git/objects/c4/714b9a764cb59ceb7dc88d6167337eecb1720a": "1253a8807369c087c2abc0cce8719726",
".git/objects/f9/6dc7cc726ad8a9ef9e168cb27bf7d00880e221": "d9913de10d4636131f010240f286f224",
".git/objects/f0/8ad27896a9ecd1caf32d6cbeb2b631cdba8e29": "dc4398dd5f6a1334c26b7341e0789382",
".git/objects/f6/f8a40b91f6108fae96679fc87a0f653443b820": "2324ba44664c88c02e69ed1014ed609f",
".git/objects/e9/d87fc0800c5c63851be2bfd01232039bc75d9f": "a12ccecab581d466a803187fd3ec6541",
".git/objects/79/72a84833176dbfd2f9c1b4442bab6a2fecceb7": "dc885d204e9afd751883c6b9d0ae719c",
".git/objects/41/346edec93cd8bb754751ed41b3d696c7a74c8b": "365dd19940f4de951a2067895640ff59",
".git/objects/77/ef25d28a37c3d89afc42115a0eb94c4bd0f1a9": "79e8a7bd2c34644bdf521179cb1675c8",
".git/objects/4f/313ca61dd4ebfc5362e5beeb7110b1bd26a9e3": "d477af5ee0c7cbf63d24d0e4ffadf6b6",
".git/objects/8d/09daa37276719137bd2a361730d4bebd3e5d0f": "e4301a42963bdf53c890a5a702933128",
".git/objects/71/3f932c591e8f661aa4a8e54c32c196262fd574": "66c6c54fbdf71902cb7321617d5fa33c",
".git/objects/76/3f0d41723d4a6422e4197fd805683053dfe241": "c701a8dbeedbaeb18120028d9908c2bf",
".git/objects/1c/f85e7caef895f02e3e877a0906f6b56c3c69d3": "2fc4f4472ec81a03b41c193e64653507",
".git/objects/49/adebdb511c8c293b28db3f6792e5bac28cdc32": "ba6a3971e7f06834fd6ec3844372ce17",
".git/objects/2e/c85b1c27e46c73e759d2c778f638c915e47b75": "732a9a9d5cc96bed59462cfbeb85247b",
".git/objects/2e/a6972703133304bef5eee992b9850f890ff7f2": "c062f963ecc79c0642c925ba07652995",
".git/objects/7f/8bce05c3590261b8c0a1638d30acb13150ac12": "74989ae45b5dd3f90ee4d99a096a24db",
".git/objects/25/a40285353bd076762709ac77ea803da93c6e19": "bc880cfeb4189b569532e2050672540b",
".git/HEAD": "5ab7a4355e4c959b0c5c008f202f51ec",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "fc1c3a7df2460e3b0137a6cd6574e4ea",
".git/logs/refs/heads/gh-pages": "fc1c3a7df2460e3b0137a6cd6574e4ea",
".git/logs/refs/remotes/origin/gh-pages": "ac4fc8427e9343b52af6c39527f545b1",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/sendemail-validate.sample": "4d67df3a8d5c98cb8565c07e42be0b04",
".git/hooks/pre-commit.sample": "5029bfab85b1c39281aa9697379ea444",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/fsmonitor-watchman.sample": "a0b2633a2c8e97501610bd3f73da66fc",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/refs/heads/gh-pages": "39a992001e334e54bd0a80c2a2e41327",
".git/refs/remotes/origin/gh-pages": "354f09846899db3e3cc549a6b6404942",
".git/index": "9c851bcf6d2ddae7d0865dfac1626cd5",
".git/COMMIT_EDITMSG": "a8913b24a6adb0f91c43019af49b4092",
"assets/AssetManifest.json": "99914b932bd37a50b983c5e7c90ae93b",
"assets/NOTICES": "daace07da711e017d8e26c8bf486b8af",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/AssetManifest.bin.json": "a1fee2517bf598633e2f67fcf3e26c94",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "0b0a3415aad49b6e9bf965ff578614f9",
"assets/fonts/MaterialIcons-Regular.otf": "483609fdf6ee3e728b9f0096232a09c7",
"browserconfig.xml": "a0dea3417d07f1c91fcb63c23d1cdd4b",
"favicon-32x32.png": "82942adaa64d8d86a87e53fcea2e43ca",
"canvaskit/skwasm.js": "5d4f9263ec93efeb022bb14a3881d240",
"canvaskit/skwasm.js.symbols": "c3c05bd50bdf59da8626bbe446ce65a3",
"canvaskit/canvaskit.js.symbols": "74a84c23f5ada42fe063514c587968c6",
"canvaskit/skwasm.wasm": "4051bfc27ba29bf420d17aa0c3a98bce",
"canvaskit/chromium/canvaskit.js.symbols": "ee7e331f7f5bbf5ec937737542112372",
"canvaskit/chromium/canvaskit.js": "901bb9e28fac643b7da75ecfd3339f3f",
"canvaskit/chromium/canvaskit.wasm": "399e2344480862e2dfa26f12fa5891d7",
"canvaskit/canvaskit.js": "738255d00768497e86aa4ca510cce1e1",
"canvaskit/canvaskit.wasm": "9251bb81ae8464c4df3b072f84aa969b",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
