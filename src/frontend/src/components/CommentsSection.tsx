import { Avatar, AvatarFallback } from "@/components/ui/avatar";
import { formatDistanceToNow } from "date-fns";
import { useComments } from "../hooks/useQueries";

interface CommentsSectionProps {
  postId: bigint;
}

export function CommentsSection({ postId }: CommentsSectionProps) {
  const { data: comments = [] } = useComments(postId);
  if (comments.length === 0) return null;

  return (
    <div className="space-y-4 pt-4 border-t">
      {comments.map((comment, index) => (
        <div key={`${comment.postId}-${index}`} className="flex gap-3">
          <Avatar className="h-8 w-8">
            <AvatarFallback className="text-[10px] bg-primary/10 text-primary">
              {getInitials(comment.authorPrincipal.toString())}
            </AvatarFallback>
          </Avatar>
          <div className="flex-1 space-y-1">
            <div className="flex items-center gap-2">
              <span className="text-sm font-medium">
                {abbreviatePrincipal(comment.authorPrincipal.toString())}
              </span>
              <span className="text-xs text-muted-foreground">
                {formatDistanceToNow(
                  new Date(Number(comment.createdAt / 1000000n)),
                  {
                    addSuffix: true,
                  },
                )}
              </span>
            </div>
            <p className="text-sm text-foreground leading-relaxed">
              {comment.body}
            </p>
          </div>
        </div>
      ))}
    </div>
  );
}

function abbreviatePrincipal(principal: string): string {
  if (principal.length <= 16) return principal;
  return `${principal.slice(0, 8)}...${principal.slice(-4)}`;
}

function getInitials(principal: string): string {
  return principal.slice(0, 2).toUpperCase();
}
