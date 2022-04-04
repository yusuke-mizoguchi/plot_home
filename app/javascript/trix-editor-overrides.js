window.addEventListener("trix-file-accept", function(event) {
    // 画像の拡張子をチェック
    const acceptedTypes = ['image/jpg', 'image/jpeg', 'image/png' ]
    if (!acceptedTypes.includes(event.file.type)) {
      event.preventDefault()
      alert("添付できる拡張子は、jpg、jpeg、pngのみです")
    }
    // 画像のbyte数をチェック
    const maxFileSize = 2048 * 2048 // 1MB 
    if (event.file.size > maxFileSize) {
      event.preventDefault()
      alert("アップできる画像は4MBまでです。")
    }
   })
