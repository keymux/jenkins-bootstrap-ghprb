// This index.dsl file will generate a Jenkins job using the
// github pull request plugin assuming it is present.

githubNamespace = 'samrocketman'
project = 'jenkins-bootstrap-ghprb'
githubProjectFull = githubNamespace + '/' + project

pipelineJob('ghprb-test-job') {
  definition {
    cpsScm {
      scm {
        git {
          remote {
            name('origin')
            github(githubProjectFull)
            refspec('+refs/heads/*:refs/remotes/origin/* +refs/pull/${ghprbPullId}/*:refs/remotes/origin/pr/${ghprbPullId}/*')
          }
          branch('${sha1}')
        }
      }
      scriptPath('Jenkinsfile')
    }
    properties {
      githubProjectUrl('https://github.com/' + githubProjectFull)
    }
    triggers {
      githubPullRequest {
        commentFilePath('github.comment.file.txt')
      }
    }
  }
}
