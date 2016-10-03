<?php
    include 'classes/database.php';

    $database = new database();

    if (@$_POST['post']) {
        $name = $_POST['name'];
        $email = $_POST['email'];
        $title = $_POST['title'];
        $body = $_POST['body'];
        $tag = $_POST['tag'];

        $database->query('INSERT INTO people (email, name) VALUES(:email, :name)');
        $database->bind(':email', $email);
        $database->bind(':name', $name);
        $database->execute();

        $database->query('INSERT INTO posts (`date`, title, body, tag, name) VALUES(NOW(), :title, :body, :tag, :name)');
        $database->bind(':title', $title);
        $database->bind(':body', $body);
        $database->bind(':tag', $tag);
        $database->bind(':name', $name);
        $database->execute();

        $database->query('INSERT INTO tags (tagName) VALUES(:tagName)');
        $database->bind(':tagName', $tag);
    }

    if (@$_POST['delete']) {
        $deleteID = $_POST['deleteID'];

        $database->query('DELETE FROM posts WHERE id = :id');
        $database->bind(':id', $deleteID);
        $database->execute();
    }

    $database->query('SELECT * FROM posts');

    $rows = $database->resultSet();
?>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Blog</title>
    </head>
    <body>
        <div>
            <h1>Make a Post</h1>
            <form action="index.php" method="post">
                <label for="name">Name: </label>
                <input type="text" name="name">

                <label for="email">Email</label>
                <input type="text" name="email">

                <label for="title">Title: </label>
                <input type="text" name="title" placeholder="Title">

                <label for="body">Body: </label>
                <input type="textarea" name="body" placeholder="Body">

                <label for="tag">Tag: </label>
                <input type="text" name="tag" placeholder="Tag">

                <input type="submit" name="post">
            </form>
        </div>

        <div>
            <h1>Posts</h1>

            <div>
                <?php foreach ($rows as $row): ?>

                <h3>
                    <?php
                        echo $row['title'];
                    ?>
                </h3>

                <p>
                    <b>
                         <?php
                            echo $row['name'];
                         ?>
                    </b>
                </p>

                <p>
                    <i>
                        <?php
                            echo $row['date'];
                        ?>
                    </i>
                </p>

                <p>
                    <?php
                        echo $row['body'];
                    ?>
                </p>

                <p>
                    <b>
                        Tags:
                        <?php
                            echo $row['tag'];
                        ?>
                    </b>
                </p>

                <form action="index.php" method="post">
                    <input type="hidden" name="deleteID" value="<?php echo $row['id']; ?>">

                    <input type="submit" name="delete" value="delete">
                </form>
                <?php endforeach ?>
            </div>
        </div>
    </body>
</html>
