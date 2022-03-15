$(document).on 'turbolinks:load', ->
  $('[data-provider="summernote"]').each ->
    $(this).summernote
      placeholder:"質問したい内容を記入しよう。一番見て欲しい箇所は色をつけるなどで強調してみよう！"
      height: 300