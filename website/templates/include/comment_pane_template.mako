<div class="scripted comment-pane">

    <div class="cp-handle-div cp-handle pull-right pointer hidden-xs" data-bind="click:removeCount" data-toggle="tooltip" data-placement="bottom" title="Comments">
        <span data-bind="if: unreadComments() !== 0">
            <span data-bind="text: displayCount" class="badge unread-comments-count"></span>
        </span>
        <i class="fa fa-comments-o fa-2x comment-handle-icon"></i>
    </div>
    <div class="cp-bar"></div>


    <div class="comments cp-sidebar" id="comments_window">
        <div class="cp-sidebar-content">
            <button type="button" class="close text-smaller" data-bind="click: togglePane">
                <i class="fa fa-times"></i>
            </button>
            <h4>
                <span data-bind="if: page() == 'files'">Files | <span data-bind="text: pageTitle"></span> Discussion</span>
                <span data-bind="if: page() == 'wiki'">Wiki | <span data-bind="text: pageTitle"></span> Discussion</span>
                <span data-bind="if: page() == 'node'"><span data-bind="text: pageTitle"></span> | Discussion</span>
            </h4>

            <div data-bind="if: canComment" style="margin-top: 20px">
                <form class="form">
                    <div class="form-group">
                        <span>
                            <p id="messageCounter">500</p>
                            <textarea id = "message" name="message" class="form-control" placeholder="Add a comment" data-bind="value: replyContent", valueUpdate: 'input'></textarea>
                        </span>
                    </div>
                    <div data-bind="if: replyNotEmpty" class="form-group">
                        <div class="clearfix">
                            <div class="pull-right">
                                <a class="btn btn-default btn-sm" data-bind="click: cancelReply, css: {disabled: submittingReply}">Cancel</a>
                                <a class="btn btn-success btn-sm" data-bind="click: submitReply, css: {disabled: submittingReply}, text: commentButtonText" id="submit"></a>
                                <span data-bind="text: replyErrorMessage" class="text-danger"></span>
                            </div>
                        </div>
                    </div>
                    <div class="text-danger" data-bind="text: errorMessage"></div>
                </form>
            </div>
            <div data-bind="template: {name: 'commentTemplate', foreach: comments}"></div>
            <!-- ko if: loadingComments -->
            ## Placeholder blank comment template with default gravitar to replace spinner
            <div class="comment-container">
                <div class="comment-body osf-box">
                    <div class="comment-info">
                        <img src="https://secure.gravatar.com/avatar/placeholder?d=identicon&s=20" alt="default">
                        <span class="comment-author">Loading...</span>
                    </div>
                    <div class="comment-content">
                        <span class="component-overflow"></span>
                    </div>
                </div>
            </div>
            <!-- /ko -->
        </div>
    </div>

</div>
<%include file="comment_template.mako" />

<%doc>
<script type="text/javascript">
    //Count characters in textarea
    function characterCount(textarea, span, maxLength) {
        if(maxLength == undefined) {
            var maxLength = 500;
        }

        var messageLength = textarea.value.length; //get length of content in the textarea
        span.innerHTML = maxLength - messageLength;
        return true;
    }

    window.onload = function() {
        document.getElementById("message").onkeyup = function() {
            characterCount(this, document.getElementById(this.id+'Counter'), 500);
        };

    $('#message').keyup(function(){
    var messageContent = $(this).val();
        //Disable submit button if the max length is reached
        if (messageContent.length > 500) {
            $('#submit').attr('disabled', 'disabled');
            $('#submit').unbind("click");
        } else {
            $('#submit').removeAttr('disabled');
            $('#submit').bind("click", submitReply);
        }
    })
};
</script>
</%doc>