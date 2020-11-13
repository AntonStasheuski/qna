$(document).on('turbolinks:load', function(){
    $('.question').on('click', '.edit-question-link', function(e) {
        e.preventDefault();
        $(this).hide();
        var questionId = $(this).data('questionId');
        $('form#edit-question-' + questionId).removeClass('hidden');
    })

    $('.question .rate-actions').on('ajax:success', function(e) {
        const rateable = e.detail[0]

        rating = rateable.rating
        id = rateable.id

        $('.question .question-rating').html(rating)
    })
});
