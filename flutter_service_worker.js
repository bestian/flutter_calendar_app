'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"favicon-16x16.png": "88c5f2ac61a8635c7cdcf47b7b64c2c0",
"flutter_bootstrap.js": "84aa59e3bcea0ea1b861cf3d2a312ac0",
"version.json": "97f0a1dbbf948731e7f8edda1b5f1a64",
"favicon.ico": "44f9a8f97c5609eda88ad4bea2fa2c7d",
"index.html": "1d6ac038c68b578821146bf4ae656fbb",
"/": "1d6ac038c68b578821146bf4ae656fbb",
"main.dart.js": "9ad290096f8b2f7157a82323aa014734",
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
".git/objects/66/a6a99a24c0d6b13edd78b00df21f85beee89a8": "d2c0b76178f62359befce5c8ab085124",
".git/objects/9b/59c486cc21bdb1c9c1d7e1ba57e5d59bcab330": "8c9f7c241a344e1cd18fec3e2c226a7f",
".git/objects/9e/6115ad2b98607c9fd8711420bf59a66b0910e0": "41e8751facff1bdcdfd779d2bfe6075f",
".git/objects/9e/26dfeeb6e641a33dae4961196235bdb965b21b": "304148c109fef2979ed83fbc7cd0b006",
".git/objects/04/9f4e7925f020bd21b45e7b18d4a2f5ba1329d7": "e72da8ea09b0155b5344b9b8cafa99dd",
".git/objects/6a/9c54a6c9cb525bed4c581a51f2551989af3087": "5dd967d840c62973ba431b26a4ccea5a",
".git/objects/6a/b0cdb0effdb1048b93f1b319224f2a92bfd4c3": "08f1596eeb77ab3bbfb090dcf351b9fa",
".git/objects/69/fe64ff90120186738aef6ca77006f9ad0f9a75": "dd2bf418efd4944dc8f51bdddee62007",
".git/objects/3c/5e3cdd62ea7b1c7b5460a5177f6b30eb2916c8": "4e37d9e674cdaf22287b3165e39bbf23",
".git/objects/51/0434fba2a02fa19f441b215f151b7246dd17f6": "87fac90c275cd01bb5c4615f9f63d894",
".git/objects/51/6f13712add8b3a572729ea9e9afc0b78763d70": "d1f501bf6c3b8d28f011e429530d39bd",
".git/objects/51/f4da55bcd44f9bbd76335a6d13d9a325929863": "1c871fd69c647959a942b708eb7af515",
".git/objects/58/04a5e0acc1d63668320b4117846a7b3c1abbf1": "c9452ee31e4bac3068fd8ed4e19a7595",
".git/objects/58/b007afeab6938f7283db26299ce2de9475d842": "6c6cbea527763bb3cdff2cecfee91721",
".git/objects/58/356635d1dc89f2ed71c73cf27d5eaf97d956cd": "f61f92e39b9805320d2895056208c1b7",
".git/objects/0b/697d3a02acb2abdc839228fd9b02aff18f74de": "6817b2b575a1e94be919e083dfdcfca6",
".git/objects/93/d7f4dfa48b993daad755500866d40136b48c70": "7b77aee58237a2a446a39829f7b1179f",
".git/objects/93/b4ad8fe85260f77e6a2576e9e21efc2b1870df": "3ad3a3a01ec1a88986170e4b438d1bae",
".git/objects/94/f7d06e926d627b554eb130e3c3522a941d670a": "77a772baf4c39f0a3a9e45f3e4b285bb",
".git/objects/05/eeb531c24336cd790a5c9fdd933c387fabedbf": "e47257a5d259df520c098559df77cece",
".git/objects/05/4554238dd5653e8f05e9a81db2e9b81a353a65": "77423d883f4cdb64e60f85615d202010",
".git/objects/9c/5fe7f3e297ff90b3c8afbe4eedc6ddf895765a": "96ebe98d86a20b86a3ccef62a0c63d6e",
".git/objects/b2/0523a049a5f0e91c5ec2b670514f3b8c9b6516": "619f46adcf017d72eb04212bed679f0d",
".git/objects/b3/aac857c8f239492f0391c04d8241bfa7a55896": "50e8328b263a6c2febf176e283ec226b",
".git/objects/b3/ebbd38f666d4ffa1a394c5de15582f9d7ca6c0": "23010709b2d5951ca2b3be3dd49f09df",
".git/objects/b4/a3ecb9428e2a4b8aff40c099e1c27d64a928f0": "6e4bc29289eb6be950713f1b329eaf0d",
".git/objects/a2/3d714e2064d0d49bbac810a7aa9adc6d265ed7": "ade99befc44afae10cd96210ebf8fab1",
".git/objects/d1/098e7588881061719e47766c43f49be0c3e38e": "f17e6af17b09b0874aa518914cfe9d8c",
".git/objects/d6/849137d7c7e13fa94e618d63c83ade5f51d3ce": "faff459d9f5bcd38bbc87cc12c7809e0",
".git/objects/d6/fcbabbdc1f9d40530cfe032328a2ed119d5fdd": "b79b79763191f32167f3d97dac66784d",
".git/objects/d6/b28c4c596e907ce19cbf3d60a79ac0f0f6bd57": "eea942c9f07e69051cdbd90f7e213dbd",
".git/objects/d6/9c56691fbdb0b7efa65097c7cc1edac12a6d3e": "868ce37a3a78b0606713733248a2f579",
".git/objects/e5/e4360debf5d9a0004b543d0342a8dcf6b1e03d": "ad4947bcd103617eec071dbedbbe2a4f",
".git/objects/e5/cb8378113d3a91e9b7a531638797a2b8d66e7e": "2cfd3e642d3d88bedb529581592be231",
".git/objects/f4/13014ad9fe2e5ea1c2f3c985455368b9c0d364": "7c2a08aa59e95af8ba2caa3c8feeb3dc",
".git/objects/f3/073060fa5b7afff0ba34e0b880009ff6c0b739": "f0b541fbb4bbe29228484da642884256",
".git/objects/eb/9b4d76e525556d5d89141648c724331630325d": "37c0954235cbe27c4d93e74fe9a578ef",
".git/objects/c9/bf8af1b92c723b589cc9afadff1013fa0a0213": "632f11e7fee6909d99ecfd9eeab30973",
".git/objects/c9/c0d666a6eef8a37ce87ff8efe1b7da68e365c3": "cc854d8f7efe24002881dab9a7c9f5b3",
".git/objects/f2/04823a42f2d890f945f70d88b8e2d921c6ae26": "6b47f314ffc35cf6a1ced3208ecc857d",
".git/objects/f2/2dfe0e73eeb649ec824cebab7680011866d83d": "197ac5582200574b7bfb6fe62dcf7ab8",
".git/objects/cf/844bec4cb5c67674e24cb3cb4dbcfd5c57002f": "7f8e6dbff7f87bd7fe7d901870f87b72",
".git/objects/e4/ef8c95bfd9470b858782640923e036429309c8": "dcf7d6e0cab0e37fdaa95886afe8e06a",
".git/objects/20/cb2f80169bf29d673844d2bb6a73bc04f3bfb8": "b807949265987310dc442dc3f9f492a2",
".git/objects/20/1afe538261bd7f9a38bed0524669398070d046": "82a4d6c731c1d8cdc48bce3ab3c11172",
".git/objects/18/8d77f85e602cca8b7800e18580390d2f4f0da6": "a724292f426dc23eb37de9ba8d6a901d",
".git/objects/18/23a647d3a8f65501ca6ce1a6359e012fb92fd4": "91bf1d6738acd8fc3a2447d534b12b00",
".git/objects/18/eb401097242a0ec205d5f8abd29a4c5e09c5a3": "4e08af90d04a082aab5eee741258a1dc",
".git/objects/29/540852a1be16f48111daf7e7f84be7974e5e3b": "02e3e636e9234a7093a70712f15ca161",
".git/objects/89/874af7e5a90e8d1364aec73236ccfdb50bda6a": "2c5cee9f75ecd40f62f208a1b0f43291",
".git/objects/1f/45b5bcaac804825befd9117111e700e8fcb782": "7a9d811fd6ce7c7455466153561fb479",
".git/objects/1f/6656b24b8a8ef57ca6253d719154b1f6ece387": "7966efa06e942de8f81b32ac8d813cda",
".git/objects/80/3671f263def09a02f79d11c1cd72e880d4dc9b": "7e5cbcba970d83a76cfc10cfdd95f8e4",
".git/objects/28/8b9f40e3e9aa59a2b55357c505f2394bb5127d": "3b21521c68c75cd00f625f3790f3f092",
".git/objects/17/e89671d9ba9bcbe77d11b267f3b31171634e51": "47ea52b34a26d74562e13b7fd5604168",
".git/objects/17/4877a99b032629376bc51eeca9bd16e64a124a": "f17d09fa32d300fc24bcdaf0cee4b0cb",
".git/objects/7b/cfbfc80015cafb425d22cc18265ddb9bb855d0": "fb2666623480b65a5d6bc079ba4d93c8",
".git/objects/8f/368292a70675725b4d450fb31a7af7e7a2465c": "f772b016eabfd2336c517d3cfb18602d",
".git/objects/8a/aa46ac1ae21512746f852a42ba87e4165dfdd1": "1d8820d345e38b30de033aa4b5a23e7b",
".git/objects/7e/ec6e1bae7107ee6ef66871ba1924e88c44f2e3": "4d8c0ce5956d442777290b89d20c9972",
".git/objects/19/91aab719f52d15bb8964508cd5de413877dca2": "c3ee606727e0e7e73e9420523056ec5d",
".git/objects/4c/ac2c103477192fd389f33bd316dea77bcdb71f": "f06d21bcc9b9f3b53db1bd777147f5d9",
".git/objects/4d/c61bb9d2f401ca4ab323a0f7f33366665d9824": "a37a294e221633f9cf171fc7992aeb0b",
".git/objects/86/d111f09a93cccfa0011858c519a823e7dafef7": "9a15839a59b5f501fbf7b9824c4b6f84",
".git/objects/2a/5e2cefbe23805238f968fb528150ee27a170c0": "9e0a4819d5d335837a037fb5827ee936",
".git/objects/2f/44ff9a911671626747bda05b25c45e2934676a": "0d6b5c92396374e3e37b364a457759d9",
".git/objects/43/a5b82a47f884dcd773ba4167dee320cbbfb699": "f3c76c3a2b700375e2fb0077c166740e",
".git/objects/88/cfd48dff1169879ba46840804b412fe02fefd6": "e42aaae6a4cbfbc9f6326f1fa9e3380c",
".git/objects/88/85f46caee7e92dc4c61f323869d19c50c7657a": "2d10c3e6016f77e1bba1286ff83d72ce",
".git/objects/9f/3cb82d4d7ea05b0108b56a14e2bb647522c9ba": "bd45f2d816f837f7b2ac17c18257b33f",
".git/objects/00/f9607fc60425b3f771837d90741622f7a002d0": "4c02bd4cc57ebd2b15d76c99426c4e27",
".git/objects/6e/820d18372f25d3cbb6d132acbf263534458b26": "5d3df8ac6da61a62d26b87f268bb9080",
".git/objects/09/4bb6ae24f0cd847d40cb4cc4a2434f2ec9b83b": "b9e6d850322c11db635bcf0a45b762ff",
".git/objects/09/c5df16366bd3e7ae6dfe0a8501a43b3f4b5d0f": "6815de5ad1b1caaab631bc58f92adffa",
".git/objects/5d/85beec86c3b76f59f432c6beff5d1d38a66cdf": "e753fa67b9430a7230f338ab369df4d6",
".git/objects/91/515c7ca08008977d2c6145d92ae50a31b2c041": "b2657c9d0d45d4f1e6d170299ab09a3b",
".git/objects/91/d8e9e0a39a9ffa01e619d9df7dabf78c108d4e": "d57d498468bdbc3c52d49594a928c31d",
".git/objects/62/cd3f25b5ce4c75a4c778c014a1fb469b624056": "e9bf68becdee4e3934f51629aae48cf9",
".git/objects/62/02c1f58289b9ff638cc422d373e73e6a6e01ca": "c30ca7ce6291adeca24e6889ba7eade2",
".git/objects/96/557123959c37ba7cd1cca420d373ae1afb734b": "db38ab912bc0b4cee390a6282949d5f2",
".git/objects/3a/bf18c41c58c933308c244a875bf383856e103e": "30790d31a35e3622fd7b3849c9bf1894",
".git/objects/30/4edca7a5523b89ce96cd7bf05a56971974ac71": "179667f1a2b082b6194396bd2a010f58",
".git/objects/37/24b9cd8b039a7cdc5e391be9994a3ca641c8d2": "121a4957d55cccd51ac0fae41bbffcea",
".git/objects/99/33b8257ce896cdfc6908e6f0f9c97aaaeb2e50": "e06d0c20c4a53a7945a03d1e1051db55",
".git/objects/63/11988f09c7daf2c0ae2ba282d3db7122421254": "52275729a48a4b8e65cdd375019e9c00",
".git/objects/0a/408a76a6f87721de893b3ccd7122c98c797f11": "d96e1df5546671a41275167086ddf599",
".git/objects/64/06bdfcef0f37074d1f13f4564380cbbf9707e8": "05619dec0e0f21028e48c4b1293d8371",
".git/objects/bf/e1c851216d9e8c18491a726e65db9e89b545ef": "4d9494ff7c779f084f157c1fb4a041ee",
".git/objects/bf/a2ce6beda7904ede76f865b9555595aa10d97e": "a0de1752fbfcbefb5aceb1d5297b1291",
".git/objects/bf/e99b6e8e9454241d61b89cabfd4ca726efe0dd": "38efd627db70468ee66bede025504c25",
".git/objects/d4/3532a2348cc9c26053ddb5802f0e5d4b8abc05": "3dad9b209346b1723bb2cc68e7e42a44",
".git/objects/d4/98357d26364260b13181ec3b0b07d7bac2f48e": "4b6f39015ddba7173d381fafc5da89d9",
".git/objects/ba/5317db6066f0f7cfe94eec93dc654820ce848c": "9b7629bf1180798cf66df4142eb19a4e",
".git/objects/a7/855361eca5b74c348200177b8bd14258f85051": "353f0fdf33c508651891de5a8d3f7549",
".git/objects/a7/756a506e3ed3d20d34442e5f4e62a8551d0f05": "4ee676aa6f393ed7a70d5383f04ab149",
".git/objects/b8/6b6aec8e44a71f704800508caba0318558a068": "2f6e4eade4d5e8b32f685b2bb556833a",
".git/objects/b1/f7d1572cbad5cd34b2fb5522a3299320c33b3c": "f7a5a65de143566e9141f73f669426e4",
".git/objects/b1/bdf943db7307709eb19fd64184b6433469b785": "6dc0f602f3fd4ee638e4cbb24bc74d09",
".git/objects/dd/3fd5353121c8a003274d787fd6ff3fe55460b2": "2eca2f6e73bc0fcc77827c41b01d9a96",
".git/objects/d5/aa7684e841ff3ec24bd3589814007ec81cadd3": "5605b70a920b74525381af7ef317547f",
".git/objects/af/b39918f0904f5b7d02ba9beaad3e5238bf2ac5": "274f011b3eb90b9d913b68abcea5d8d9",
".git/objects/b7/49bfef07473333cf1dd31e9eed89862a5d52aa": "36b4020dca303986cad10924774fb5dc",
".git/objects/b7/d2731bcf406214fc2ac578617919e16ecea0e2": "5f7beae64d0e829eb9c770ae6c3d0b33",
".git/objects/a8/99386aeedb8f99d5a91afc9fd6af7e1ef33c2a": "fead583b75928e3b9b15957556b18b77",
".git/objects/b0/cbed12c3f1aeceb3484d3e943655b05530a04d": "2f2f0b088861d9ec12cda444f22ce16a",
".git/objects/b0/30a40035bf94eb7626c8bded35b40e8102a081": "54ac361230c0b5411f76365650b9ad8a",
".git/objects/b9/2a0d854da9a8f73216c4a0ef07a0f0a44e4373": "f62d1eb7f51165e2a6d2ef1921f976f3",
".git/objects/ef/662e50425b8d447de583ed154e699faa55a0c4": "bca1c77fc57bcd3c5d6b3800f9f20749",
".git/objects/c3/8966946f392fb441dc5b7e04301cc78faab442": "356a2d5745c3fda3217292a0d7b85fc6",
".git/objects/c4/714b9a764cb59ceb7dc88d6167337eecb1720a": "1253a8807369c087c2abc0cce8719726",
".git/objects/f9/6dc7cc726ad8a9ef9e168cb27bf7d00880e221": "d9913de10d4636131f010240f286f224",
".git/objects/f9/add110243e5dc8552341c527377bbaf7c2bab3": "3bcaf63847d6783b949e17f89ec8911e",
".git/objects/f0/e52b778864b5888c38d514bad654967fe6ac66": "ed07920154fdc5514ee4c2a73210988d",
".git/objects/f0/8ad27896a9ecd1caf32d6cbeb2b631cdba8e29": "dc4398dd5f6a1334c26b7341e0789382",
".git/objects/f6/f8a40b91f6108fae96679fc87a0f653443b820": "2324ba44664c88c02e69ed1014ed609f",
".git/objects/e9/d87fc0800c5c63851be2bfd01232039bc75d9f": "a12ccecab581d466a803187fd3ec6541",
".git/objects/f1/6bbf319277a55921a08f729018900eeb3c2bb4": "c7381cdd96ebc7791889a3819be8c1c5",
".git/objects/f8/ee35c3a151931fb352f215d2775f4fc344802a": "4913aa0337661ce794d1b58a0e8c1c34",
".git/objects/ce/cb71158d254fdfed336fa9af3b96e58f251d22": "4465ca1d3d2194bac8cd77448701bcaa",
".git/objects/e0/eeef6adf12747c3c97177cda9006add8314d12": "68abca774da57b31a6715929c3eac44b",
".git/objects/46/4ab5882a2234c39b1a4dbad5feba0954478155": "2e52a767dc04391de7b4d0beb32e7fc4",
".git/objects/2c/1be2a8acc659ea06002cb019b7d4204b1923c6": "f43d3e145242abc8b151a4c5354a7275",
".git/objects/79/72a84833176dbfd2f9c1b4442bab6a2fecceb7": "dc885d204e9afd751883c6b9d0ae719c",
".git/objects/41/346edec93cd8bb754751ed41b3d696c7a74c8b": "365dd19940f4de951a2067895640ff59",
".git/objects/77/ef25d28a37c3d89afc42115a0eb94c4bd0f1a9": "79e8a7bd2c34644bdf521179cb1675c8",
".git/objects/77/920d8d0c62c26ab217931efe912441157a260d": "ed0ce429f960255bab12df9c43a0e698",
".git/objects/1e/151312cfcdeba0a70f62f997e63632f84681cb": "cebd425d12fb6574009f124144d08155",
".git/objects/4f/313ca61dd4ebfc5362e5beeb7110b1bd26a9e3": "d477af5ee0c7cbf63d24d0e4ffadf6b6",
".git/objects/8d/09daa37276719137bd2a361730d4bebd3e5d0f": "e4301a42963bdf53c890a5a702933128",
".git/objects/8c/9780b10505550e963cf1d21b3b33f3dbf7f858": "4aabf2fc3b7fba0fa59f9a3642e43fe8",
".git/objects/85/6a39233232244ba2497a38bdd13b2f0db12c82": "eef4643a9711cce94f555ae60fecd388",
".git/objects/71/2c76e42b0488b7ee29148eba7610b9372d5ded": "98258482df5563215595c3364407468b",
".git/objects/71/3f932c591e8f661aa4a8e54c32c196262fd574": "66c6c54fbdf71902cb7321617d5fa33c",
".git/objects/76/3f0d41723d4a6422e4197fd805683053dfe241": "c701a8dbeedbaeb18120028d9908c2bf",
".git/objects/1c/f85e7caef895f02e3e877a0906f6b56c3c69d3": "2fc4f4472ec81a03b41c193e64653507",
".git/objects/49/adebdb511c8c293b28db3f6792e5bac28cdc32": "ba6a3971e7f06834fd6ec3844372ce17",
".git/objects/40/f142625cbe370b5defcce5e20e3a77bc4d3f48": "42983802c3a8bdc65e6f94a8d9a52898",
".git/objects/2e/c85b1c27e46c73e759d2c778f638c915e47b75": "732a9a9d5cc96bed59462cfbeb85247b",
".git/objects/2e/a6972703133304bef5eee992b9850f890ff7f2": "c062f963ecc79c0642c925ba07652995",
".git/objects/2e/c92a763e5f708238845e1b98f61ffa0a72e40d": "08ada53f16c997de411252003d037061",
".git/objects/2b/50b90b8648f90674d6b57ad9ca9a0faf90312b": "e4e37426029819b824bfb353a2c4e77c",
".git/objects/78/c87f662143d5002444988492501453544794db": "34f86cfe5c1217738c3de1ad3c8d9360",
".git/objects/7f/8bce05c3590261b8c0a1638d30acb13150ac12": "74989ae45b5dd3f90ee4d99a096a24db",
".git/objects/8e/75dba311572054cac97d6268fd315c9ca0e7ca": "cb9c4597a5e092ab67ee3b95be39d653",
".git/objects/25/8b3eee70f98b2ece403869d9fe41ff8d32b7e1": "05e38b9242f2ece7b4208c191bc7b258",
".git/objects/25/2b1d3f676f87a385601bdbd7a3ac9cde8d302c": "9244d63e80fa1c8b7c416fb1d7890616",
".git/objects/25/a40285353bd076762709ac77ea803da93c6e19": "bc880cfeb4189b569532e2050672540b",
".git/HEAD": "5ab7a4355e4c959b0c5c008f202f51ec",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "db3ba8adca8faae94fc1e20eedbdd02a",
".git/logs/refs/heads/gh-pages": "db3ba8adca8faae94fc1e20eedbdd02a",
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
".git/refs/heads/gh-pages": "eadcb10242d6d827edb983b9a42ad937",
".git/refs/remotes/origin/gh-pages": "354f09846899db3e3cc549a6b6404942",
".git/index": "cd9e58f829e50f11340dfdbc1ffdd975",
".git/COMMIT_EDITMSG": "a8913b24a6adb0f91c43019af49b4092",
"assets/AssetManifest.json": "c26ade903825f9a747e781be10955085",
"assets/NOTICES": "a730de0da2f74abb4b26cf4dabde38f1",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin.json": "b9f841f6f1b4550b35e495deb7171dbf",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/lib/img/hero.png": "2bc173323bfa50e248d232c2c8de845a",
"assets/AssetManifest.bin": "00c5f4662e53cb0db217195a44dc8250",
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
