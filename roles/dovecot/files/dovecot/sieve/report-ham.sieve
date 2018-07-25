require ["vnd.dovecot.pipe", "copy", "imapsieve", "environment", "variables"];

if environment :matches "imap.mailbox" "*" {
  set "mailbox" "${1}";
}

# This line is important because when we delete from Junk/Spam,
# messages get moved to Trash, which tirggers the "message moved out of
# spam" script (this script) which—usually!—trains the originally classified
# Spam as not-spam.
# BUT, this is just a delete! If we train our spam as not-spam on delete, that
# defeats our goals.
# In short, this always gets run on a message being moved out of Spam, but if
# the target mailbox is Trash, just don't run the trainer this time.
if string "${mailbox}" "Trash" {
  stop;
}

if environment :matches "imap.email" "*" {
  set "email" "${1}";
}

pipe :copy "train-ham.sh" [ "${email}" ];
